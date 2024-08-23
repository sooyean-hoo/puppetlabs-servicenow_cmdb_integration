#!/bin/bash

pepasswd_def=pie$(date +%s )piepiepiepiepiepiepiepiepieP5!

if [ -e /tmp/p.txt ] ; then
  source /tmp/p.txt ;
fi
pepasswd=${pepasswd:-$pepasswd_def}

version=`puppet --version`
echo "===Puppet Version Installed=${version}==="

apt install -y curl || yum install -y curl 
curl -q "https://raw.githubusercontent.com/sooyean-hoo/pe_curl_requests/feature/SYInstallerEnhance/installer/download_pe_tarball.sh"  > /tmp/download_pe_tarball.sh
source /tmp/download_pe_tarball.sh  loadlib

installPkg curl cron crontabs 
installPkg gnupg  gnupg2 gnupg1  
installPkg ruby-devel.x86_64 ruby-bundler ruby-all-dev ruby-dev ruby-full
installPkg git git-core zlib* zlib*-dev g++     patch                    libyaml* libffi-dev                 make bzip2 autoconf automake libtool bison curl cmake 
installPkg git curl autoconf bison build-essential \
  libssl-dev libyaml-dev libreadline6-dev zlib1g-dev \
  libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev  

  
if [ -z "$version" ]; then
  
  PE_RELEASE=2019.8.1
  PE_RELEASE=2023.7.0
  PE_RELEASE=""
  PE_RELEASE=2021.7.8
  
#  PE_LATEST=$(curl https://artifactory.delivery.puppetlabs.net/artifactory/generic_enterprise__local/archives/releases/${PE_RELEASE}/LATEST)
  PE_FILE_NAME=puppet-enterprise-${PE_LATEST}-ubuntu-18.04-amd64
  TAR_FILE=${PE_FILE_NAME}.tar
#  DOWNLOAD_URL=https://artifactory.delivery.puppetlabs.net/artifactory/generic_enterprise__local/archives/releases/${PE_RELEASE}/${TAR_FILE}

  ## Download PE
#   curl -o ${TAR_FILE} ${DOWNLOAD_URL}
#   

  ls -l  ${TAR_FILE}
  if [[ $? -ne 0 ]];then
    export DOWNLOAD_VERSION=${PE_RELEASE}
    export tmpDir="$PWD" ;

    
    cd $tmpDir && rm -fr ./puppet*.gz  &&   pwd && \
    cat /tmp/download_pe_tarball.sh | bash - ;
    ls -l "./puppet*.gz"
    cp -f "./puppet*.gz" ${TAR_FILE}
    echo "Done the CURL one "
  fi ;
  ls -l ${TAR_FILE} > /dev/null 2>/dev/null


  ## Another New Way to Download

  #puppet --version

  if [[ $? -ne 0 ]];then
    
    export DOWNLOAD_VERSION=${PE_RELEASE}
    export tmpDir="$PWD" ;
    
    touch $tmpDir/occkeys

    cleanse_dlPEConsole
    cd $tmpDir && rm -fr ./puppet*.gz  &&   pwd 
    dlPEConsole_SetParameters ${PE_RELEASE} && \
    dlPEConsole ${PE_RELEASE}  | tee  /tmp/aaaa.txt
    echo "================================================================================================="
    grep -E 'puppet.+gz' /tmp/aaaa.txt | sed -E 's/^.+(puppet.+gz).+$/\1/g' | head -1
    echo "================================================================================================="
    tarfilenow=`grep -E 'puppet.+gz' /tmp/aaaa.txt | sed -E 's/^.+(puppet.+gz).+$/\1/g' | head -1 | sed -E 's/^.+puppet/puppet/g' `
    sudo chmod a+rw "${tarfilenow}" ||  chmod a+rw "${tarfilenow}"
    sudo ls -l "${tarfilenow}" || ls -l "${tarfilenow}" 
    echo sudo cp -f "$tmpDir/puppet*.gz" ${TAR_FILE} || \
    echo      cp -fv "$tmpDir/${tarfilenow}" ${TAR_FILE}
    
    TAR_FILE="${tarfilenow}"
    PE_FILE_NAME=${TAR_FILE/.tar.gz/}
    echo "Done the dlPEConsole one with ${tarfilenow}"  
  fi ;
  ls -l ${TAR_FILE} > /dev/null 2>/dev/null


  if [[ $? -ne 0 ]];then
    echo “Error: wget failed to download [${DOWNLOAD_URL}]”
    exit 2
  fi

  ## Install PE
  tar xvf ${TAR_FILE}
  if [[ $? -ne 0 ]];then
    echo “Error: Failed to untar [${TAR_FILE}]”
    exit 2
  fi


  stages="=SETVALUES==PRECHECK==UNTAR==SETHOCONFVALUES==PREP="
  hostname=puppet
  #echo "127.0.0.1 puppet puppet" > /etc/hosts
  cat > $tmpDir/installPEConsole.SETVALUES.txt << ___E
display_local_time=true
adminpasswd="$pepasswd"
puppet_master_host=${hostname}    
___E
  
  touch /tmp/occkeys
  
  echo installPEConsole  ${stages}
  puppet resource host   `puppet config print certname`  ip=127.0.0.1 || echo  "127.0.0.1 `puppet config print certname` `puppet config print certname`" >> /etc/hosts
  puppet resource host   puppet  ip=127.0.0.1 || echo  "127.0.0.1 puppet puppet" >> /etc/hosts
  puppet resource host   `puppet config print certname`  ip=127.0.0.1 || echo  "127.0.0.1  `puppet config print certname`  `puppet config print certname`" >> /etc/hosts
  puppet resource host   `hostname`.delivery.puppetlabs.net  ip=127.0.0.1 || echo  "127.0.0.1 `hostname`.delivery.puppetlabs.net   `hostname`.delivery.puppetlabs.net " >> /etc/hosts
  
  
  
  delivery.puppetlabs.net
  
  echo "================="
  cat /etc/hosts
  echo "================="
  cat /etc/hostname
  echo "================="

  cd ${PE_FILE_NAME}
  echo "================="
  cat ./conf.d/pe.conf
  echo "================="
  printf 'y' | ./puppet-enterprise-installer

  
  if [[ $? -ne 0 ]];then
    echo “Error: Failed to install Puppet Enterprise. Please check the logs and call Bryan.x ”
    exit 2
  fi
fi

  ## Finalize configuration
  
  puppetcmd=`find /opt  -iname puppet -type f  -maxdepth 4 | grep bin | grep -v bolt | head -1`
  which puppet  || echo 'export PATH='$(dirname  ${puppetcmd:-/usr/bin/ls} )':$PATH'  >> $HOME/.bashrc
  
  source $HOME/.bashrc
  export PATH="$(dirname  ${puppetcmd:-/usr/bin/ls} ):$PATH"

  echo “Finalize PE install”
  puppet agent -t


  puppet infra console_password --password=${pepasswd}

  ## Create and configure Certs
  echo "autosign = true" >> /etc/puppetlabs/puppet/puppet.conf

  ## Setup the RBAC token
  echo "${pepasswd}" | puppet access login --lifetime 1y --username admin

version=`puppet --version`

if [ -z "$version" ];  then
  echo 'puppet install failed'
  exit 1
fi
