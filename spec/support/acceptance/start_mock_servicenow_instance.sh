#!/bin/bash

mkdir -p /tmp/servicenow
apt install -y curl || yum install -y curl 

curl -q "https://raw.githubusercontent.com/sooyean-hoo/pe_curl_requests/feature/SYInstallerEnhance/installer/download_pe_tarball.sh"  > /tmp/download_pe_tarball.sh 
source /tmp/download_pe_tarball.sh  loadlib

# The following Codes are only activated if you place a file @ /tmp/servicenow/start_mock_servicenow_instance.sh. And the file can be empty.
# This run the servicenow locally.
if [ -e  /tmp/servicenow/start_mock_servicenow_instance.sh ] ; then
  export tmpDir=$PWD
  
  cd /tmp/servicenow/

  
     
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

function oraclelinuxrepo(){
  test -d /etc/yum.repos.d || return 404    # Exclude non Yum - Driven OS
  
      # # Adding CentOS Extras to Oracle Enterprise Linux
      # 
      # If you want to install a package like Docker Community Edition on OEL, you'll have to add the CentOS Extras repo, which as of release 7 is built-in to CentOS and not added on later like EPEL is. As a result, instructions for adding it to EL7 are hard to find. This should work for any build of Enterprise Linux that does not already include the CentOS Extras repo. I have absolutely no idea if it's apporpriate to use this repo on a build of Linux *other* than CentOS, but it should be.
      # 
      # This was tested on Oracle Enterprise Linux 7, but should be copy-pastable on any version or EL build assuming things don't change too much.
      # 
      # ## Download the CentOS GPG Key
      # 
      # ```bash
      # Get OS Release number
      OS_RELEASE=$(rpm -q --qf "%{VERSION}" $(rpm -q --whatprovides redhat-release))
      OS_RELEASE_MAJOR=$(echo $OS_RELEASE | cut -d. -f1)
      
      # Download the GPG key and save locally
      curl -s https://www.centos.org/keys/RPM-GPG-KEY-CentOS-$OS_RELEASE_MAJOR | sudo tee /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$OS_RELEASE_MAJOR
      
      # ```
      ## Create the repo file
      # 
      # A bash implementation of [this stackoverflow answer](https://unix.stackexchange.com/a/52683/209779):
      # 
      # ```bash
      # Get OS Release number
      OS_RELEASE=$(rpm -q --qf "%{VERSION}" $(rpm -q --whatprovides redhat-release))
      OS_RELEASE_MAJOR=$(echo $OS_RELEASE | cut -d. -f1)
      # Create the repo file
      cat << EOF | sudo tee /etc/yum.repos.d/centos-extras.repo
#additional packages that may be useful
[extras]
name=CentOS-$OS_RELEASE_MAJOR - Extras
mirrorlist=http://mirrorlist.centos.org/?release=$OS_RELEASE_MAJOR&arch=\$basearch&repo=extras
#baseurl=http://mirror.centos.org/centos/$OS_RELEASE_MAJOR/extras/\$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$OS_RELEASE_MAJOR
priority=1
EOF
      # ```
      
      ## Build the repo cache
      
      #```bash
      sudo yum -q makecache -y --disablerepo='*' --enablerepo='extras' || 
      (
        sudo sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo ;
        sudo sed -i s/^#.*baseurl=http/baseurl=https/g /etc/yum.repos.d/*.repo ;
        sudo sed -i s/^mirrorlist=http/#mirrorlist=https/g /etc/yum.repos.d/*.repo ;

        echo "sslverify=false" | sudo tee -a /etc/yum.conf
        sudo yum upgrade -y ;
      )
      #```
      
}
function enableDocker(){
  
  rep=$(curl -s --unix-socket /var/run/docker.sock http://ping > /dev/null )
  status=$?
  
  if [ "$status" == "7"    ] ; then
     echoMsg '!!' Docker for Ubuntu
  
      apt-get -qq update -y 1>&- 2>&-
      apt-get install -qq docker.io -y 1>&- 2>&- 
  fi
  
  rep=$(curl -s --unix-socket /var/run/docker.sock http://ping > /dev/null )
  status=$?
  
  # Redhat Version
  if [ "$status" != "0"    ] ; then
    rep=$(curl -s  /var/run/docker.sock http://ping > /dev/null )
    status=$?
    if [ "$status" == "6"    ] ; then
      echoMsg '!!' Docker for RedHat
      
      # Enabled Extra Repo......
      
      sudo yum remove docker \
                    docker-client \
                    docker-client-latest \
                    docker-common \
                    docker-latest \
                    docker-latest-logrotate \
                    docker-logrotate \
                    docker-engine \
                    podman \
                    runc
      sudo yum install -y yum-utils ; 
      
      (( sudo yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo || sudo curl --add-repo https://download.docker.com/linux/rhel/docker-ce.repo    -o  /etc/yum.repos.d/docker-ce.repo ) &&
        sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 
      )|| (
          oraclelinuxrepo ;
          pkgs="docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin" ;
      
          installPkg $pkgs || ( sudo yum-config-manager --disablerepo docker-ce-stable ; rm -f /etc/yum.repos.d/docker-ce.repo ; installPkg podman-docker  ) || ( 
          curl -O https://raw.githubusercontent.com/AlmaLinux/almalinux-deploy/master/almalinux-deploy.sh | sudo bash -  ;
          ( sudo yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo || sudo curl --add-repo https://download.docker.com/linux/rhel/docker-ce.repo    -o  /etc/yum.repos.d/docker-ce.repo ) &&
           sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 
          )     
       )
    fi
  fi; 

  rep=$(curl -s --unix-socket /var/run/docker.sock http://ping > /dev/null )
  status=$?

# SLES Version
  if [ "$status" == "7"    ] ; then
    echoMsg '!!' Docker for SLES
  
    opensuse_repo="https://download.opensuse.org/repositories/security:/SELinux/openSUSE_Factory/security:SELinux.repo"
    sudo zypper addrepo $opensuse_repo
    
    sudo zypper remove docker \
                    docker-client \
                    docker-client-latest \
                    docker-common \
                    docker-latest \
                    docker-latest-logrotate \
                    docker-logrotate \
                    docker-engine \
                    runc
      
      yes a | sudo zypper addrepo --gpgcheck-allow-unsigned-repo  --enable  https://download.docker.com/linux/sles/docker-ce.repo << __EEE
a
a
__EEE
    sudo zypper --gpg-auto-import-keys ref
    
    echo pkg_gpgcheck = off  | sudo tee -a /etc/zypp/zypp.conf
    echo repo_gpgcheck = off | sudo tee -a /etc/zypp/zypp.conf
    
    echo "Done zypper addrepo"
    yes a | sudo zypper install  -y  docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin << __EEE
a
a
__EEE \
||   yes a | sudo zypper install -y   docker << __EEE
a
a
__EEE
    sudo systemctl start docker
    
  fi; 

}


enableDocker




function cleanup() {
  # bolt_upload_file isn't idempotent, so remove this directory
  # to ensure that later invocations of the setup_servicenow_instance
  # task _are_ idempotent
  rm -rf /tmp/servicenow
}
trap cleanup EXIT

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
