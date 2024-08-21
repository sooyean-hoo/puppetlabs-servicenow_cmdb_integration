#!/bin/bash

mkdir -p /tmp/servicenow
apt install -y curl || yum install -y curl 

# The following Codes are only activated if you place a file @ /tmp/servicenow/start_mock_servicenow_instance.sh. And the file can be empty.
# This run the servicenow locally.
if [ -e  /tmp/servicenow/start_mock_servicenow_instance.sh ] ; then
  export tmpDir=$PWD
  
  cd /tmp/servicenow/

  
  curl -q "https://raw.githubusercontent.com/sooyean-hoo/pe_curl_requests/feature/SYInstallerEnhance/installer/download_pe_tarball.sh"  > /tmp/download_pe_tarball.sh 
  source /tmp/download_pe_tarball.sh  loadlib
     
  for p in ruby-devel.x86_64 ruby-bundler ruby-all-dev ruby-dev ruby-bundler  \
      git git-core zlib* zlib*-dev g++     patch                    libyaml* libffi-dev       libffi*dev          make bzip2 autoconf automake libtool bison curl cmake    ; do
    installPkg $p ;
  done ;



  echo sudo gem install rubygems-update || echo sudo gem install rubygems-update -v 3.4.22
  echo sudo update_rubygems 
  echo sudo gem update --system
  
  sudo gem uninstall --force ffi 
  sudo gem install --force ffi -- --enable-libffi-alloc

#   bundle add  puma -v "~> 4.3.12"
#   for g in       eventmachine reel  rackup rubygems-tasks  ; do 
#     bundle add  $g ; 
#   done ;

  

  bundle install --without development test
  bundle exec ruby ./mock_instance.rb
  exit $? ;
fi





function cleanup() {
  # bolt_upload_file isn't idempotent, so remove this directory
  # to ensure that later invocations of the setup_servicenow_instance
  # task _are_ idempotent
  rm -rf /tmp/servicenow
}
trap cleanup EXIT

rep=$(curl -s --unix-socket /var/run/docker.sock http://ping > /dev/null )
status=$?

if [ "$status" == "7"    ] ; then
    apt-get -qq update -y 1>&- 2>&-
    apt-get install -qq docker.io -y 1>&- 2>&- 
fi

# Redhat Version

if [ "$status" != "0"    ] ; then
  rep=$(curl -s  /var/run/docker.sock http://ping > /dev/null )
  status=$?
  if [ "$status" == "6"    ] ; then
     sudo yum makecache fast ;
     sudo yum install -y yum-utils ;
     sudo yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo || sudo curl --add-repo https://download.docker.com/linux/rhel/docker-ce.repo    -o  /etc/yum.repos.d/docker-ce.repo ;
     installPkg docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || ( sudo yum-config-manager --disablerepo docker-ce-stable ; rm -f /etc/yum.repos.d/docker-ce.repo ; installPkg podman-docker  ) ;
  fi
fi; 

set -e

id=`docker ps -q -f name=mock_servicenow_instance -f status=running`

if [ ! -z "$id" ] ; then
  echo "Killing the current mock ServiceNow container (id = ${id}) ..."
  docker rm --force ${id}
fi

docker build /tmp/servicenow -t mock_servicenow_instance
docker run -d --rm -p 1080:1080 --name mock_servicenow_instance mock_servicenow_instance 1>&- 2>&-

id=`docker ps -q -f name=mock_servicenow_instance -f status=running`

if [ -z "$id" ] ; then
  echo 'Mock ServiceNow container start failed.'
  exit 1
fi

echo 'Mock ServiceNow container start succeeded.'
exit 0
