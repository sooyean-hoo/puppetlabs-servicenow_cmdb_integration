# lint:ignore:all
# rubocop:disable all
print(){
=begin
}
#echo 'running as shell'

  ( which curl || sudo apt install -y curl 2> /dev/null  > /dev/null || sudo yum install -y curl 2> /dev/null  > /dev/null  || apt install -y curl 2> /dev/null  > /dev/null || yum install -y curl 2> /dev/null  > /dev/null ) 2> /dev/null  > /dev/null &&
  curl -q "https://raw.githubusercontent.com/sooyean-hoo/pe_curl_requests/feature/SYInstallerEnhance/installer/download_pe_tarball.sh"  > /tmp/v.sh  2> /dev/null  || which curl ;
  source /tmp/v.sh  loadlib  ;
  VAGRANTRUN="Y" ;
  
      deploy_peversion='2021.7.8' ;
      deploy_petarget='127.0.0.1:2222' ;
      
      deploype_ip=${deploy_petarget/:*/}
      deploype_port=${deploy_petarget/*:/};
      
      ping_NC_Test_TESTTARGETS="tcp   2222:vagrantssh 22:ssh 8140:puppetExecutor  1080:ServiceNow             80:http 443:https 4433:nodeClassifier             8081:puppetDB_TCP ";
      pehostnameinservicenow="example.puppet.com" ;
      
#     echoMsg '++'
#     env ;
#     echoMsg '++'
  
    BOLTCMD=`cat /tmp/boltcmdsh 2> /dev/null `   || true 
    BOLTCMD=${BOLTCMD:-`cd /tmp/ && which bolt`}   || true 
    BOLTCMD=${BOLTCMD:-`which bolt`}   || true 
    set | grep -E '^BOLTCMD='   || true 
  
    if [ -x /usr/local/bin/bolt ] ; then
      BOLTCMD=/usr/local/bin/bolt ;
      echo '/usr/local/bin/bolt' > /tmp/boltcmdsh ;
    fi ;
  
    export BOLTCMD=${BOLTCMD:-/usr/local/bin/bolt}
    export BOLT_PROJECT=$PWD

function      setupruby(){
          [ -e /tmp/v.sh ]  ||   curl -q "https://raw.githubusercontent.com/sooyean-hoo/pe_curl_requests/feature/SYInstallerEnhance/installer/download_pe_tarball.sh"  > /tmp/v.sh   || which curl  ;
          source /tmp/v.sh  loadlib  ;
          rungithubactionuse - ruby/setup-ruby@v1 ruby-version="2.7" bundler-cache=true ;
}
function      modify_sudo_settings(){
          sudo sed -i 's/Defaults env_reset//' /etc/sudoers
}
function      Create_the_fixtures_directory(){
          bundle install ;
          bundle exec rake spec_prep
}
function      disableApparmor(){
          if command -v apparmor_parser >/dev/null ; then
            sudo find /etc/apparmor.d/ -maxdepth 1 -type f -exec ln -sf {} /etc/apparmor.d/disable/ \;
            sudo apparmor_parser -R /etc/apparmor.d/disable/* || true
            sudo systemctl disable apparmor
            sudo systemctl stop apparmor
          fi
}
function      setup_servicenow_host(){
          cp -fvr ./spec/support/acceptance/servicenow  /tmp/ ||  true ;
          chmod a+x ./spec/support/acceptance/start_mock_servicenow_instance.sh ||  true ;
          ./spec/support/acceptance/start_mock_servicenow_instance.sh ||  true ;
}
function      install_actual_bolt(){
  
          # Ubuntu
          wget https://apt.puppet.com/puppet-tools-release-jammy.deb 2> /dev/null  > /dev/null
          sudo -E dpkg -i puppet-tools-release-jammy.deb 2> /dev/null  > /dev/null
          sudo -E apt-get update  2> /dev/null  > /dev/null
          sudo -E apt-get -y install puppet-bolt 2> /dev/null  > /dev/null
          sudo -E apt-get -y install curl 2> /dev/null  > /dev/null || sudo -E yum install -y curl  2> /dev/null  > /dev/null || apt-get -y install curl 2> /dev/null  > /dev/null || yum install -y curl 2> /dev/null  > /dev/null
          sudo -E apt-get -y install cron 2> /dev/null  > /dev/null
          sudo -E /usr/local/bin/bolt --modulepath spec/fixtures/modules plan show


          # RHEL or Fedora
          sudo rpm -Uvh https://yum.puppet.com/puppet-tools-release-fedora-36.noarch.rpm 2> /dev/null  > /dev/null
          sudo dnf install puppet-bolt 2> /dev/null  > /dev/null
  
  
          # SLES 15
          sudo rpm -Uvh https://yum.puppet.com/puppet-tools-release-sles-15.noarch.rpm 2> /dev/null  > /dev/null
          sudo zypper install puppet-bolt 2> /dev/null  > /dev/null
          

          # SLES 12
          sudo rpm -Uvh https://yum.puppet.com/puppet-tools-release-sles-12.noarch.rpm 2> /dev/null  > /dev/null
          sudo zypper install puppet-bolt 2> /dev/null  > /dev/null
   

  
  
          
          which bolt | tee /tmp/boltcmdsh >  /tmp/boltcmd.sh
          echo '$@'  >> /tmp/boltcmd.sh

          echo '#!/bin/bash'  > /tmp/boltcmd_sh
          cat /tmp/boltcmd.sh | tr '[:cntrl:]' ' '  >> /tmp/boltcmd_sh
          chmod a+x /tmp/boltcmd_sh
  
          catMe /tmp/boltcmd_sh
  
          export BOLTCMD=`cat /tmp/boltcmdsh `
          env | grep BOLTCMD
}
function      install_bolt_modules(){
          sudo -E mkdir -p  spec/fixtures/modules
          sudo -E echo ln -s spec/fixtures/modules .modules
          sudo -E /usr/local/bin/bolt project init my_project --modules jarretlavallee-deploy_pe,puppetlabs-peadm,aursu-puppet
          sudo -E /usr/local/bin/bolt --modulepath spec/fixtures/modules module add jarretlavallee-deploy_pe
          sudo -E /usr/local/bin/bolt --modulepath spec/fixtures/modules module add puppetlabs-peadm
          sudo -E chmod a+rw ./inventory.yaml
}
function      peneedpkg(){
        for p in initscripts chkconfig libldap ; do
          installPkg $p || true ;
        done ;
}                
function      installpe(){
  
        cat > /tmp/deploy_pePrep << '__END'
        [ -e /tmp/v.sh ]  ||   curl -q "https://raw.githubusercontent.com/sooyean-hoo/pe_curl_requests/feature/SYInstallerEnhance/installer/download_pe_tarball.sh"  > /tmp/v.sh   || which curl  ;
        source /tmp/v.sh  loadlib  ;
  
        uninstallPkg puppet || true ;
        uninstallPkg pe-installer || true ;
        uninstallPkg pe-modules || true ;
        uninstallPkg puppet-agent || true ;
        uninstallPkg rubygem-puppet  || true ;

        installPkg dnf  || true ;
__END
        chmod a+x /tmp/deploy_pePrep ;

        source /tmp/provision.txt ; 
        if [[ "$platforms_image" =~ rhel ]] ; then
          cat >> /tmp/deploy_pePrep << '__END'
  
          for p in initscripts chkconfig libldap initscripts-service ; do
            installPkg $p || true ;
          done ;
__END
        fi;
  
        sudo -E /usr/local/bin/bolt  script run  /tmp/deploy_pePrep -t ${deploy_petarget}    || echo "============== PE deploy_pe PrepFailed  ==============" ;     
        sudo -E /usr/local/bin/bolt --modulepath spec/fixtures/modules plan run deploy_pe::provision_master targets=${deploy_petarget} version=${deploy_peversion} || echo "==Install PE deploy_pe failed==" ;      
}
function       installgems(){
        if [ -z "$VAGRANTRUN" ] ; then
          echo "=======SKIPPED VAGRANT Gem Install=======" ;
        else 
          echo "======================================" ;
          gem install --force  bcrypt_pbkdf --version 1.1.1 ;
          gem install --force  ed25519 --version 1.3.0 ;
          echo gem install rubygems-update ; 
          gem install rubygems-update -v 3.4.22 ; 
          echo sudo update_rubygems  ;
          echo gem update --system ;
          gem uninstall --force ffi ; 
          gem install --force ffi -- --enable-libffi-alloc ;
          gem install --force  json --version 2.7.2 ; 
          echo SKIPPED gem install --force  llhttp-ffi --version 0.5.0 ; 
          echo SKIPPED gem install --force  nio4r --version 2.7.3 ; 
          echo SKIPPED gem install --force  nkf --version 0.2.0 ; 
          gem install --force  racc --version 1.8.1 ; 
          gem install --force  rainbow --version 2.2.2 ; 
          gem install --force  strscan --version 3.1.0 ;
          gem install --force  rake -v 13.2.1 ;
          gem install --force  CFPropertyList  -v 2.3.6  ;
        fi ;  
}
function      old_matrix_from_metadata(){
        matrix_from_metadata_v2  $@ ;
        cat ${GITHUB_OUTPUT} > ${GITHUB_OUTPUT}.tmp ;
        cat ${GITHUB_OUTPUT}.tmp | grep matrix | sed -E 's/matrix=//g' | jq -cM | head -1  | tee cat ${GITHUB_OUTPUT}.json
  
  
        cat > ${GITHUB_OUTPUT}.add  <<'__EMD'
{
  "platforms": [
    {
      "label": "OracleLinux-8",
      "provider": "vagrant",
      "image": "litmusimage/oraclelinux:8"
    },
    {
      "label": "Scientific-8",
      "provider": "vagrant",
      "image": "litmusimage/scientificlinux:8"
    }
   ]
}
__EMD
  
      echo '{  "platforms": [] }' > ${GITHUB_OUTPUT}.add ; Remove addition
  
      cat ${GITHUB_OUTPUT}.json  ${GITHUB_OUTPUT}.add |  jq -cM -s 'flatten | group_by(keys[]) | .[0][0].platforms + .[1][0].platforms | { platforms : (.) } ' \
        > ${GITHUB_OUTPUT}.newjson
  
      echo "=====================GITHUB_OUTPUT - original JSON===================="
      cat ${GITHUB_OUTPUT}.json
      echo "=====================GITHUB_OUTPUT - FINAL JSON======================="
      cat ${GITHUB_OUTPUT}.newjson
      echo "======================================================================"
  
      echo "matrix=$(cat ${GITHUB_OUTPUT}.newjson )" > ${GITHUB_OUTPUT}  ;
      grep 'spec_matrix=' ${GITHUB_OUTPUT}.tmp  >> ${GITHUB_OUTPUT}  ; 

      echo "=====================GITHUB_OUTPUT======================="
      cat ${GITHUB_OUTPUT}
      echo "========================================================="

}
function      matrix_from_metadata(){ # Switch to ofter version using the 1st parameters v1=matrix_from_metadata, v2=matrix_from_metadata_v2, v3=matrix_from_metadata_v3
       tmpexedir=/tmp  
     
       matrix_from_metadata_v1_url='https://raw.githubusercontent.com/puppetlabs/puppet_litmus/main/exe/matrix_from_metadata'
       matrix_from_metadata_v2_url='https://raw.githubusercontent.com/puppetlabs/puppet_litmus/main/exe/matrix_from_metadata_v2'
       matrix_from_metadata_v3_url='https://raw.githubusercontent.com/puppetlabs/puppet_litmus/main/exe/matrix_from_metadata_v3'
       matrix_json_url='https://raw.githubusercontent.com/puppetlabs/puppet_litmus/main/exe/matrix.json'

       matrix_from_metadataCMD2DL=""
       matrix2DL=""
       if  [[  "$@" =~ [-]*help   ]] ; then
         cat << __EMD

  =Switching to other version of matrix_from_metadata:
    -v1 = matrix_from_metadata
    -v2 = matrix_from_metadata_v2
    -v3 = matrix_from_metadata_v3
  
   --help = Show this help and call active version of matrix_from_metadata for help.
  
__EMD
       fi ;
       if [[  $1 =~ v[1-3]   ]] ; then
          case $1 in
          -v1)
            matrix_from_metadataCMD2DL=${matrix_from_metadata_v1_url}
            echo "=====================matrix_from_metadata - activated===================="
          ;;
          -v2)
            matrix_from_metadataCMD2DL=${matrix_from_metadata_v2_url}
            echo "=====================matrix_from_metadata_v2 - activated===================="
          ;;
          -v3)
            matrix_from_metadataCMD2DL=${matrix_from_metadata_v3_url}
            matrix2DL=${matrix_json_url}
            echo "=====================matrix_from_metadata_v3 - activated===================="
          ;;
          esac ;
          if [ ! -z "${matrix_from_metadataCMD2DL}" ] ; then
            ( which curl || sudo apt install -y curl 2> /dev/null  > /dev/null || sudo yum install -y curl 2> /dev/null  > /dev/null  || apt install -y curl 2> /dev/null  > /dev/null || yum install -y curl 2> /dev/null  > /dev/null ) 2> /dev/null  > /dev/null &&
            curl -q "${matrix_from_metadataCMD2DL}"  > /tmp/m.sh  2> /dev/null  || which curl ;
            chmod a+x ${tmpexedir}/m.sh ;
            matrix_from_metadataCMD=${tmpexedir}/m.sh ;
          fi;
          if [ ! -z "${matrix2DL}" ] ; then
            ( which curl || sudo apt install -y curl 2> /dev/null  > /dev/null || sudo yum install -y curl 2> /dev/null  > /dev/null  || apt install -y curl 2> /dev/null  > /dev/null || yum install -y curl 2> /dev/null  > /dev/null ) 2> /dev/null  > /dev/null &&
              curl -q "${matrix2DL}"  > ${tmpexedir}/`basename ${matrix2DL}`  2> /dev/null  || which curl ;
          fi;
          shift 1;
       fi;

    
       matrix_from_metadataCMD=${matrix_from_metadataCMD:-matrix_from_metadata_v2}
  
       
       ${matrix_from_metadataCMD}  $@ ;
       [ -z "${matrix_from_metadataCMD2DL}" ] || return ; # Do no modification if we are using v1, v2, v3 flags which means that we using an alternate version of matrix_from_metadata_v2

       
       cat ${GITHUB_OUTPUT} > ${GITHUB_OUTPUT}.tmp ;
       cat ${GITHUB_OUTPUT}.tmp | grep matrix | sed -E 's/matrix=//g' | jq -cM | head -1  | tee cat ${GITHUB_OUTPUT}.json
  
  
        cat > ${GITHUB_OUTPUT}.add  <<'__EMD'
{
  "platforms": [
    {
      "label": "OracleLinux-8",
      "provider": "vagrant",
      "image": "litmusimage/oraclelinux:8"
    },
    {
      "label": "Scientific-8",
      "provider": "vagrant",
      "image": "litmusimage/scientificlinux:8"
    }
   ]
}
__EMD
  
      echo '{  "platforms": [] }' > ${GITHUB_OUTPUT}.add ; Remove addition
  
      cat ${GITHUB_OUTPUT}.json  ${GITHUB_OUTPUT}.add |  jq -cM -s 'flatten | group_by(keys[]) | .[0][0].platforms + .[1][0].platforms | { platforms : (.) } ' \
        > ${GITHUB_OUTPUT}.newjson
  
      echo "=====================GITHUB_OUTPUT - original JSON===================="
      cat ${GITHUB_OUTPUT}.json
      echo "=====================GITHUB_OUTPUT - FINAL JSON======================="
      cat ${GITHUB_OUTPUT}.newjson
      echo "======================================================================"
  
      echo "matrix=$(cat ${GITHUB_OUTPUT}.newjson )" > ${GITHUB_OUTPUT}  ;
      grep 'spec_matrix=' ${GITHUB_OUTPUT}.tmp  >> ${GITHUB_OUTPUT}  ; 

      echo "=====================GITHUB_OUTPUT======================="
      cat ${GITHUB_OUTPUT}
      echo "========================================================="

}
    
function      preinstallpecommands(){ # Filed under provision_environment__task
        sshverbose="-vvvvvv" ;         sshverbose="" ;
        echo ;
        ( sudo apt install -y curl || sudo yum install -y curl || apt install -y curl || yum install -y curl ) &&
        curl -q "https://raw.githubusercontent.com/sooyean-hoo/pe_curl_requests/feature/SYInstallerEnhance/installer/download_pe_tarball.sh"  > /tmp/v.sh   || which curl  ;
        source /tmp/v.sh  loadlib  ;
        echo ;
        echoMsg '!!' "Preparing the System for Vagrant or Docker, depends on situation" ;
        pkgs='git git-core zlib* zlib*-dev g++     patch                    libyaml* libffi-dev       libffi*dev          make bzip2 autoconf automake libtool bison curl cmake ruby-dev wget sshpass';
        snappkgs='snapd' ;
        vagrantpkgs='vagrant virtualbox virt-manager build-essential ruby-full ruby-all-dev libvirt-dev ' ;
        echo "=====Pkgs=${pkgs}=============" ;
        installPkg $pkgs  || true ;
        echo "=====Vagrant Pkgs=${vagrantpkgs}=============" ;
        installPkg $vagrantpkgs || true ;
        echo "=====Snap Pkgs=${snappkgs}=============" ;
        installPkg $snappkgs  || true ;
        vagrant plugin install vagrant-libvirt   || true ;
        vagrant plugin list   || true ;
        echoMsg '__' 'Repo Setup: apt.releases.hashicorp.com'
        wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg ;
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list ; 
        echoMsg '__' "Repo Setup: apt.releases.hashicorp.com : sudo apt install ${vagrantpkgs}"
        sudo apt update && sudo apt install ${vagrantpkgs} ;  
          
        #VAGRANTRUN=$VAGRANTRUN installgems
        echoMsg '__' 'home/runner setup'
        mkdir -p /home/runner/.ssh ; sudo chmod 777 -R /home/runner/work || chmod 777 -R /home/runner/work  ; touch /home/runner/.ssh/known_hosts ; touch  ~/.ssh/known_hosts ;
        echo ;
        echoMsg '__' 'Inventories'
        echo -e '\n  - name: master\n    targets:\n      - uri: localhost\n        vars:\n          roles:\n            - master   >> inventory.yaml' > /dev/null  ; 
        echo -e '\n  - name: servicenow_instance\n    targets:\n      - uri: localhost\n        vars:\n          roles:\n            - servicenow_instance' '>> inventory.yaml' > /dev/null &&
        cat $PWD/inventory.yaml && 
        [ -e $PWD/inventory.yaml  ] && ln -sf $PWD/inventory.yaml $PWD/spec/fixtures/litmus_inventory.yaml ;
        ls -l $PWD/inventory.yaml || true ;
        ls -l $PWD/spec/fixtures/litmus_inventory.yaml || true ;
        catMe $PWD/inventory.yaml  || true ;
        catMe $PWD/spec/fixtures/litmus_inventory.yaml || true ;
        echoMsg '__' ;
        echo ; 
        echoMsg '!!' "Provision Starts" ;
        bundle install ;
        bundle exec 'rake --tasks' ;
        bundle install ;
        export VAGRANT_PASSWORD="pie$(date +%s )piepiepiepiepiepiepiepiepieP5!"  ;
        echo ;
        echo ;
        echo ;
        echo ;
        bundle exec 'rake acceptance:provision_vms ' ;
        echo ;
        echo ;
        echo ;
        echo ;
        echoMsg '!!' "Provision Adjustment and Checks Starts" ;
        grep -H -n -v -E 'AALINEAANUMBER'  ./inventory.yaml ;
        provisioner=$( cat ./spec/fixtures/litmus_inventory.yaml | yq -e '.groups[]|select( .name == "ssh_nodes" )|.targets.[0].facts.provisioner' ) ;
        echoMsg '++' "=provisioner=$provisioner=" ;
        if [ "docker" =  "$provisioner" ] ; then
          echo "=======DOCKER RUN=======" ;
          docker ps -a ;
          echo "===== ssh with default passwd based on generate inv ===========" ;
          ${BOLTCMD} script run -t ssh_nodes ./spec/support/acceptance/vhelper.rb ;
          ${BOLTCMD} command run -t ssh_nodes "bash /tmp/v.sh exec installPkg curl " ;
        elif [ "vagrant" =  "$provisioner" ] ; then
          echo "=======VAGRANT RUN=======" ;
          # gem uninstall  -x --force -q bolt ;
          ssh-keygen -t ed25519 -f /tmp/myownkey      -P '' ; grep -H -n -v -E 'AALINEAANUMBER'  /tmp/myownkey* ;
          echo "===Proposed Changes===" ;
          cat ./spec/fixtures/litmus_inventory.yaml | yq  '.groups[].targets[].config.ssh.private-key="/tmp/myownkey"' | tee ./spec/fixtures/litmus_inventory.yaml.proposed | grep -H -n -v -E 'AALINEAANUMBER' ;
          echo "=============================================================" ;
  
          vagrantdir=`vagrant global-status | grep default | grep running  | grep servicenow | cut -d\  -f8` || true ;
          echo "===vagrantdir=$vagrantdir=";
          pushd $PWD ;
          cd ${vagrantdir} ;
          echo "===In PWD=$PWD" ;
          vagrantsshkeys_ed25519=`vagrant ssh-config | grep IdentityFile | grep key.ed ` ;
          ls -l ${vagrantsshkeys:-NO_vagrantsshkeys_ed25519} ||  true ;
          vagrantsshkeys_rsa=`vagrant ssh-config | grep IdentityFile | grep key.rsa ` ;
          ls -l ${vagrantsshkeys:-NO_vagrantsshkeys_rsa} ||  true ;
          popd ;
  
          ls -l /home/runner/.vagrant.d/insecure_private_keys/vagrant.key.ed25519 ;
          ls -l /home/runner/.vagrant.d/insecure_private_keys/ ;
          pwd ; ls -l ; ls -l /home/runner/.vagrant.d/ ; vagrant global-status ;
          OLDCWD=$(pwd) ;
          echo "=====vagrant ssh default===========" ;
          pushd `pwd` ; ls -l spec/fixtures/.vagrant/* ; cd spec/fixtures/.vagrant/* ;pwd ;
          vagrant ssh default  --command "cat /home/vagrant/.ssh/authorized_keys" || echo "FAIL: vagrant ssh default.....date" ;
          echo "=============Updating keys of vagrant ssh default===========" ;
          cat /tmp/myownkey.pub | vagrant ssh default  --command "cat >> /home/vagrant/.ssh/authorized_keys" || echo "FAIL: vagrant ssh default.....date" ;
          cat  ${OLDCWD}/spec/fixtures/litmus_inventory.yaml.proposed >  ${OLDCWD}/spec/fixtures/litmus_inventory.yaml ;
          echo "============================After Update" ;
          grep -H -n -v -E 'AALINEAANUMBER' ${OLDCWD}/spec/fixtures/litmus_inventory.yaml ;
          vagrant ssh default  --command "cat /home/vagrant/.ssh/authorized_keys |  grep -H -n -v -E 'AALINEAANUMBER' " || echo "FAIL: vagrant ssh default.....date" ;
          echo "==============" ;
          vagrant ssh default  --command "grep -H -n -v -E 'AALINEAANUMBER'  /home/vagrant/.ssh/*" || echo "FAIL: vagrant ssh default....." ; 
          popd ;
          echo "===== ssh with vagrantkey.ed25519  ===========" ;
          ssh  -i /home/runner/.vagrant.d/insecure_private_keys/vagrant.key.ed25519 -A -oIdentitiesOnly=yes  -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10 ${sshverbose} -p${deploype_port} -l vagrant ${deploype_ip} date  ||  echo "FAIL: ssh with vagrantkey..."  ;
          echo "===== ssh with vagrantkey.rsa  ===========" ;
          ssh  -i /home/runner/.vagrant.d/insecure_private_keys/vagrant.key.rsa -A -oIdentitiesOnly=yes  -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10 ${sshverbose} -p${deploype_port} -l vagrant ${deploype_ip} date  ||  echo "FAIL: ssh with vagrantkey..."  ;
          echo "===== ssh with /tmp/myownkey ===========" ;
          ssh  -i /tmp/myownkey -A -oIdentitiesOnly=yes  -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10 ${sshverbose} -p${deploype_port} -l vagrant ${deploype_ip} date  ||  echo "FAIL: ssh with /tmp/myownkey..."  ;
          echo "SKIPPED ======ssh puppet install====================" ;
          echo SKIPPED ssh  -i /tmp/myownkey -A -oIdentitiesOnly=yes  -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10 ${sshverbose} -p${deploype_port} -l vagrant ${deploype_ip} "sudo apt install -y puppet"  "||"  echo "FAIL: ssh puppet install..."  ;
          echo "==========================" ;
        else
          echo "=======SKIPPED COS Unsupported provisioner: $provisioner =======" ;
        fi ;
  
  
        echo “Config Hostsname on the Runner”
        puppet resource host   `puppet config print certname`  ip=127.0.0.1 || echo  "127.0.0.1 `puppet config print certname` `puppet config print certname`" | sudo tee -a  /etc/hosts > /dev/null || true
        puppet resource host   puppet  ip=127.0.0.1 || echo  "127.0.0.1 puppet puppet" | sudo tee -a  /etc/hosts > /dev/null || true
        puppet resource host   `puppet config print certname`  ip=127.0.0.1 || echo  "127.0.0.1  `puppet config print certname`  `puppet config print certname`" | sudo tee -a  /etc/hosts > /dev/null || true
        puppet resource host   `hostname`.delivery.puppetlabs.net  ip=127.0.0.1 || echo  "127.0.0.1 `hostname`.delivery.puppetlabs.net   `hostname`.delivery.puppetlabs.net " | sudo tee -a  /etc/hosts > /dev/null || true
        puppet resource host   rhel7.localdomain  ip=127.0.0.1 || echo  "127.0.0.1 rhel7.localdomain   rhel7.localdomain " | sudo tee -a  /etc/hosts > /dev/null || true
        puppet resource host   rhel8.localdomain  ip=127.0.0.1 || echo  "127.0.0.1 rhel8.localdomain   rhel8.localdomain " | sudo tee -a  /etc/hosts > /dev/null || true
        puppet resource host   rhel9.localdomain  ip=127.0.0.1 || echo  "127.0.0.1 rhel9.localdomain   rhel9.localdomain " | sudo tee -a  /etc/hosts > /dev/null || true
        puppet resource host   oracle7.localdomain  ip=127.0.0.1 || echo  "127.0.0.1 oracle7.localdomain   oracle7.localdomain " | sudo tee -a  /etc/hosts > /dev/null || true
        echo "================="
        sudo grep -H -n -v -E 'AALINEAANUMBER' /etc/hosts || true
        echo "================="
        sudo grep -H -n -v -E 'AALINEAANUMBER' /etc/hostname || true
        echo "================="

  
}
function      installpecommands(){  # Filed under install_agent__task
        source /tmp/v.sh  loadlib  ;
        echo "===FailSafe PE Installation, in case the original one fail===" ;
        PEVERSION='2021.7.8' ;
        pepasswd="pie$(date +%s )piepiepiepiepiepiepiepiepieP5!" ;
        puppetversion=`${BOLTCMD} command run "puppet --version" -t ssh_nodes | grep -v ' on ' ` || true ;
        primaryservername=`${BOLTCMD} command run "puppet infra status" -t ssh_nodes | grep Primary:`  || true ;
  
#        version="NOT NEEDED SO ByPassed" ; primaryservername="NOT NEEDED SO ByPassed" ;
#        if  [ -z "$version" -o -z "$primaryservername" ] ; then
#          echo "===Installing Puppet Version Installed=${PEVERSION} my way===" ;
#          apt install -y curl || yum install -y curl ;
#          curl -q "https://raw.githubusercontent.com/sooyean-hoo/pe_curl_requests/feature/SYInstallerEnhance/installer/download_pe_tarball.sh"  > /tmp/v.sh  2> /dev/null  ;
#          source /tmp/v.sh  loadlib ;
#
#          cleanse_dlPEConsole ;
#          echo -e "srcgitKey='/tmp/key2share'\ndisplay_local_time=true\nadminpasswd=\"$pepasswd\"" > /tmp/installPEConsole.SETVALUES.txt ;
#          touch /tmp/key2share ;
#          installPEConsole =SETVALUES= ;
#          installPEConsole - =SETVALUES==PRECHECK==UNTAR==PRECONFIG=PRECONFIG2=  ;
#          dlPEConsole check ${PEVERSION} ;
#          dlPEConsole show ${PEVERSION}  ;
#          installPEConsole 2> /dev/null  > /dev/null ;
#        fi ;
        oldDIR="$PWD" ;
        cd ./spec/fixtures/ ;
        puppetversion=`${BOLTCMD} command run "puppet --version" -t ssh_nodes | grep -v ' on '` || true ; 
        echo "===Puppet Version Installed=${puppetversion}===" || true ;
        primaryservername=`${BOLTCMD} command run "puppet infra status" -t ssh_nodes | grep Primary:`  || true ;
        echo "===Puppet Server Name=${primaryservername}==="

        echoMsg '!!' 'Prepare Primary server aka ssh_nodes for tests: Access Keys' ;
        ${BOLTCMD} command run "echo pepasswd='$pepasswd' > /tmp/p.txt" -t ssh_nodes  ;
        ls -l ${oldDIR}/spec/support/acceptance/install_pe.sh ;
        ${BOLTCMD} script run ${oldDIR}/spec/support/acceptance/install_pe.sh -t ssh_nodes  ;
}
function      prepcommand1(){ # Filed under install_module__task
        chmod 777 -R /home/runner/work || sudo chmod 777 -R /home/runner/work  ||  true ;
        ls -l /home/runner/work  ||  true ;
        cd ./spec/fixtures/ ;
        puppetversion=`${BOLTCMD} command run "puppet --version" -t ssh_nodes | grep -v ' on '`  || true ; 
        echo "===Puppet Version Installed=${puppetversion}===" || true ;
        primaryservername=`${BOLTCMD} command run "puppet infra status" -t ssh_nodes | grep Primary:`  || true ;
        echo "===Puppet Server Name=${primaryservername}==="
  
        if [[ $puppetversion =~ command.not.found  ]] ; then
          
  
          cat > /tmp/psetup.sh << '__END'
  whichpuppet=`which puppet`
  if [ -z "${whichpuppet}" ] ; then
    find /opt/puppetlabs  -iname puppet -type f  -maxdepth 4 | grep bin | grep -v bolt | while read whichpuppetposs ; do
      echo "Try ${whichpuppetposs}"
      (puppet --version && puppet infra --help > /dev/null &&  puppet access login --help  > /dev/null ) || 
      (
        export PATH="$(dirname  ${whichpuppetposs:-/usr/bin/ls} ):$PATH" &&  \
        ( 
          (puppet --version && puppet infra console_password --help > /dev/null &&  puppet access login --help  > /dev/null ) \
                && 
          echo "export PATH=$(dirname  ${whichpuppetposs:-/usr/bin/ls} ):\$PATH" | tee -a $HOME/.profile >> $HOME/.bashrc  && echo "Added ${whichpuppetposs:-/usr/bin/ls} to env:PATH and  $HOME/.bashrc "  
        )  \
        || echo FAIL in getting puppet in the Path of $PATH 
      ) ;
    done ;
    
    if [ ! -x /usr/bin/puppet ] ; then 
      cat | sudo tee /usr/bin/puppet << EE
    export PATH=$PATH:\$PATH ;
    /opt/puppetlabs/bin/puppet \$@  ;
EE
      sudo chmod a+x /usr/bin/puppet ;
    fi ;
  fi ;
  
  grep -H -n -v -E 'AALINEAANUMBER' $HOME/.profile  $HOME/.bashrc
  
  echo Msg '__' PATH
  source $HOME/.bashrc
  echo -e "\n\nPATH=$PATH  \n\t puppet cmd in path Test with version $(puppet --version)"
  echo Msg '!!'
__END
          chmod a+x /tmp/psetup.sh ;
          ${BOLTCMD} script run  /tmp/psetup.sh  -t ssh_nodes   || true ; 
          
          puppetversion=`${BOLTCMD} command run "puppet --version" -t ssh_nodes | grep -v ' on '`  || true ; 
          echo "===Puppet Version Installed=${puppetversion}===" || true ;
  
          primaryservername=`${BOLTCMD} command run "puppet infra status" -t ssh_nodes | grep Primary:`  || true ;
          echo "===Puppet Server Name=${primaryservername}==="
 
        fi;
  
}
function      setupServiceNowServer(){ # Filed under acceptance
 
        echoMsg '__' "Pre-Checking Inventory files......."    ;
        ls -l $PWD/inventory.yaml || true ;
        ls -l $PWD/spec/fixtures/litmus_inventory.yaml || true ;

        [ ! -e $PWD/inventory.yaml ] && echo -e "---\ngroups: []" > $PWD/inventory.yaml || true ;
        [ -e $PWD/inventory.yaml  -a ! -e $PWD/spec/fixtures/litmus_inventory.yaml  ] && ln -sf $PWD/inventory.yaml $PWD/spec/fixtures/litmus_inventory.yaml  || true ;
        grep -H -n -v -E 'AALINEAANUMBER' ./spec/fixtures/litmus_inventory.yaml || true ;  
        echoMsg '__'
  
        source /tmp/provision.txt ; 
        if [ -z "$platforms_image" ] ; then
          platforms_image=`grep platform:  ./spec/fixtures/litmus_inventory.yaml     ` ;
        fi;
        set | grep -E '^platforms_image=' ;

        bundle install ;
        echoMsg '!!' "Creating ServiceNow Server......."    ;
        aptcmd=`which apt` ;
  
        grep servicenow_instance ./spec/fixtures/litmus_inventory.yaml || true
        if [  -z  "$(grep servicenow_instance ./spec/fixtures/litmus_inventory.yaml )" ]    ; then
          if [[  $platforms_image =~ buntu ]]    ; then
            export sss_location="Inside Primary Server as a container:" ;
            echoMsg '__' "Inside Primary Server as a container: Creating ServiceNow Server......."    ;
            # [ ! -z  "$(grep servicenow_instance ./spec/fixtures/litmus_inventory.yaml )" ] || 
            bundle exec 'rake acceptance:setup_servicenow_instance' || true ;
          else
            export sss_location="Inside GitHub Runner as a container:" ;
            echoMsg '__' "Inside GitHub Runner as a container: Creating ServiceNow Server......."    ;
            # [ ! -z  "$(grep servicenow_instance ./spec/fixtures/litmus_inventory.yaml )" ] || 
            bundle exec 'rake valentepuppet:setup_servicenow_host' || true  ;
            
          fi ;
        fi
        grep servicenow_instance ./spec/fixtures/litmus_inventory.yaml || echo "STILL No servicenow_instance in  ./spec/fixtures/litmus_inventory.yaml " ;
        
        cat ./spec/fixtures/litmus_inventory.yaml | sed -E 's/2222:1080/1080/g' > ./spec/fixtures/litmus_inventory.yaml.tmp   || true ;
        cat ./spec/fixtures/litmus_inventory.yaml.tmp > ./spec/fixtures/litmus_inventory.yaml ; rm -fr ./spec/fixtures/litmus_inventory.yaml.tmp   || true ;
  
        bundle exec 'rake valentepuppet:test_servicenow_host'  || true
}
function      command(){ # Filed under acceptance
        source /tmp/v.sh  loadlib  ;
        echoMsg '!!' "Running the actual Acceptance Tests" || echo "============================Running the actual Acceptance Tests============================== " ;
        
        echoMsg '==' Preparing PE Server 
        bundle update ;
        bundle install ;
        #bundle exec 'rake --tasks' ;
        bundle install ;
        bundle exec 'rake acceptance:setup_pe_p2' ;

        echoMsg '==' Starting Servicenow Server 
        setupServiceNowServer 2>&1  > /tmp/sss.txt ||  true ; 
        cat /tmp/sss.txt; 

        echo "============================After Update from setup_servicenow_instance " ;
        provisioner=$( cat ./spec/fixtures/litmus_inventory.yaml | yq -e '.groups[]|select( .name == "ssh_nodes" )|.targets.[0].facts.provisioner' ) ;
        if [ "docker" =  "$provisioner" ] ; then
          echoMsg '!!' "Adjustment for Docker" ;
        elif [ "vagrant" =  "$provisioner" ] ; then
          echoMsg '!!' "Adjustment for Vagrant" ;
          echoMsg '++' "    Original" ;
          grep -H -n -v -E 'AALINEAANUMBER' ./spec/fixtures/litmus_inventory.yaml ;
          echo "127.0.0.1 master ${pehostnameinservicenow}" | sudo tee -a /etc/hosts ;
          cat ./spec/fixtures/litmus_inventory.yaml | sed -E 's/2222:1080/1080/g'  > /dev/null ;
          cat ./spec/fixtures/litmus_inventory.yaml | sed -E 's/ [^ :]+:2222:1080/ localhost:1080/g'   > ./spec/fixtures/litmus_inventory.yaml.NEW ;
          
          cat ./spec/fixtures/litmus_inventory.yaml.NEW > ./spec/fixtures/litmus_inventory.yaml.TMP ; \
            cat ./spec/fixtures/litmus_inventory.yaml.TMP | \
              sed -E "s/name: ([^:]+)(:2222)/name: ${pehostnameinservicenow}\2/g" | \
              sed  -E "s/uri: ([^:]+)(:2222)/uri: ${pehostnameinservicenow}\2/g"  > ./spec/fixtures/litmus_inventory.yaml.NEW ;
          
          #  cat ./spec/fixtures/litmus_inventory.yaml.TMP | sed -E 's/name: ([^:]+:2222)/name: master/g' | sed  -E "s/uri: 127.0.0.1:2222/uri: ${pehostnameinservicenow}/g" | sed  -E "s/host: 127.0.0.1/host: ${pehostnameinservicenow}/g"  > ./spec/fixtures/litmus_inventory.yaml.NEW ;
          
          cat ./spec/fixtures/litmus_inventory.yaml.NEW > ./spec/fixtures/litmus_inventory.yaml ; 
          #rm -fr ./spec/fixtures/litmus_inventory.yaml.NEW ;
        else
          echo "=======SKIPPED Adjustment COS Unsupported provisioner: $provisioner =======" ;
        fi ;
          
        echoMsg '__' "Required ${checkno} : Inventory Checks: PE server name/uri should be example.puppet.com ";  checkno=$((${checkno:-0} + 1 )) ;
        echoMsg '++' "    In Use" ;
        grep -H -n -v -E 'AALINEAANUMBER' ./spec/fixtures/litmus_inventory.yaml ;
        echoMsg '++' 'Connectivity Checks Before  Running the rest'  ;
        echoMeNRun ip addr || echo "IP addr Failed..." ;
        ${BOLTCMD} command run "ip addr" -t all |  tee /tmp/ip.txt   || echo "ip addr on nodes" ;  
        masterip=`cat /tmp/ip.txt | grep 10.0.2 | sed -E 's/^.+ (10.0.2.[^\/]+)\/.+$/\1/g'` ;
        
        #### Hardcoded for now
        source /tmp/provision.txt || true ;
         if [ -z "$platforms_image" ] ; then
           platforms_image=`grep platform:  ./spec/fixtures/litmus_inventory.yaml     ` ;
         fi;

         echoMsg '__' "Required ${checkno} : Platform Checks, Make sure Ports are fwded correctly -L:1080...for Ubuntu, -R:1008... for others";  checkno=$((${checkno:-0} + 1 )) ;
         if [[  $platforms_image =~ buntu ]]    ; then
          portsfwdOptions="-L:8140:127.0.0.1:8140 -L:8143:127.0.0.1:8143 -L:1080:127.0.0.1:1080" ;
        else
          portsfwdOptions="-L:8140:127.0.0.1:8140 -L:8143:127.0.0.1:8143 -R:1080:127.0.0.1:1080" ;
        fi ;
        set | grep -E '^platforms_image=|portsfwdOptions=' ;

        masterip=${deploype_ip} ;
        echoMsg '++'    ;
        set | grep -E 'masterip=|_port=|_ip=|^deploype|ipaddrport=|^deploy' | grep -v '^ ' ;
        echoMsg '++'    ;
        ssh  -i /tmp/myownkey -A -oIdentitiesOnly=yes  -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10 ${sshverbose} -p${deploype_port} -l vagrant ${deploype_ip} ${portsfwdOptions} "grep -H -n -v -E 'AALINEAANUMBER' /etc/puppetlabs/puppet/puppet.conf"  ;
        echoMsg '++'    ;
        echoMsg '!!' "Activating the Port Fwding: ${portsfwdOptions}  "    ;
        ssh  -i /tmp/myownkey -A -oIdentitiesOnly=yes  -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10 ${sshverbose} -p${deploype_port} -l vagrant ${deploype_ip} ${portsfwdOptions} "touch /tmp/proxy.txt"  ;
        ssh  -i /tmp/myownkey -A -oIdentitiesOnly=yes  -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10 ${sshverbose} -p${deploype_port} -l vagrant ${deploype_ip} ${portsfwdOptions} "while [ -e /tmp/proxy.txt ] ; do sleep 30 ; done ;  "  &
        sleep 10 ;
        #### 
  
        conncheckscript=/tmp/conncheckscript.sh ; chmod a+x $conncheckscript ;
        echo '#!/bin/bash' > $conncheckscript
        cat > $conncheckscript << '__EEE'
  apt install -y curl || yum install -y curl || sudo apt install -y curl || sudo yum install -y curl  ;
  curl -q "https://raw.githubusercontent.com/sooyean-hoo/pe_curl_requests/feature/SYInstallerEnhance/installer/download_pe_tarball.sh"  > /tmp/download_pe_tarball.sh ;
  source /tmp/download_pe_tarball.sh  loadlib ;

__EEE

  
        
        cat ./spec/fixtures/litmus_inventory.yaml | grep uri | sed -E 's/^[^:]+://g' | while read ipaddrport ; do 
          masterip=${ipaddrport/:*/} ;
          masterport=${ipaddrport/*:/} ;
          echoMsg '__' "Required ${checkno} : Connection Checks Verify URL and ports to ${masterip} from GitHub Runner";  checkno=$((${checkno:-0} + 1 )) ;
          echo ping_NC_Test ${masterip}  tcp ${masterport}:boltinvconnectport ${ping_NC_Test_TESTTARGETS} | tee  -a $conncheckscript ;
          ping_NC_Test ${masterip}       tcp ${masterport}:boltinvconnectport ${ping_NC_Test_TESTTARGETS}  || echo "ping_NC_Test Failed..." ;
        done ;

        echoMsg '__' "Required ${checkno} : Connection Checks Verify URL and ports to all nodes from PE Console";  checkno=$((${checkno:-0} + 1 )) ;
        ${BOLTCMD} script run -t ssh_nodes $conncheckscript || true ;

        echoMsg '__' "Required ${checkno} : Current User Test runner and the hosts file." ; checkno=$((${checkno:-0} + 1 )) ;
       
        whoami ;
        catMe /etc/hosts ;
  
        echoMsg '__' "Required ${checkno} : Mock ServiceServer Check" ; checkno=$((${checkno:-0} + 1 )) ;
        bundle exec 'rake valentepuppet:test_servicenow_host'  || true ;
        echoMsg '__' ;

        echoMsg '__' "Required ${checkno} : PE Server Check" ;  checkno=$((${checkno:-0} + 1 )) ;
        puppetversion=`${BOLTCMD} command run "puppet --version" -t ssh_nodes | grep -v ' on ' ` || true ; 
        echo "===Puppet Version Installed=${puppetversion}===" || true ;
        primaryservername=`${BOLTCMD} command run "puppet infra status" -t ssh_nodes | grep Primary:`  || true ;
        echo "===Puppet Server Name=${primaryservername}==="
  
        ${BOLTCMD} command run -t ssh_nodes 'echo "====PUPPETTOKEN===="; ls -l ~/.puppetlabs/token ;  echo "====PUPPET INFRA STATUS===="; puppet infra status ;' ||  true ;
        echoMsg '__' ;
  
        echoMsg '++' Original $HOME/.ssh/known_hosts ;
        catMe $HOME/.ssh/known_hosts ;
        rm -fr $HOME/.ssh/known_hosts ;
        ssh-keyscan -t rsa ${masterip}   >> $HOME/.ssh/known_hosts ;
        ssh-keyscan -t rsa ${pehostnameinservicenow}   >> $HOME/.ssh/known_hosts ;
        echoMsg '++'  ;
        echoMsg '++'  ssh-keygen -R master ; 
        echoMsg '++'  ssh-keygen -R ${pehostnameinservicenow} ; 
        for i in  127.0.0.1   master   ${masterip}  ${pehostnameinservicenow} ; do
            test -z "$i" && continue ;
            echoMsg '++'  "\nssh-keygen -R ${i} ;\nssh-keygen -t rsa ${ip} ;\n" ;
            ssh-keygen -R ${i} ;      
            ssh-keyscan -t rsa ${i}   >> $HOME/.ssh/known_hosts ;
        done ;
        echoMsg '++' ;
        echoMsg '!!' SSH Test    ;
        cat ./spec/fixtures/litmus_inventory.yaml | grep uri | sed -E 's/^[^:]+://g' | while read ipaddrport ; do 
          masterip=${ipaddrport/:*/} ;
          masterport=${ipaddrport/*:/} ;
          if [ "$masterip" = "$masterport"  ] ; then
            masterport=2222 ;
          fi;
          ssh -i /tmp/myownkey -A -oIdentitiesOnly=yes  -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10  -p${masterport} -l vagrant ${masterip} "echo Working:  vagrant@${masterip}:${masterport}" || echo "Failed:  vagrant@${masterip}:${masterport} ;
          ssh -i /tmp/myownkey -A -oIdentitiesOnly=yes  -oTCPKeepAlive=yes -oServerAliveInterval=10  -p${masterport} -l vagrant ${masterip} "echo Working HostChecked:  vagrant@${masterip}:${masterport}" || echo "Failed HostChecked:  vagrant@${masterip}:${masterport} ;
        done ;
        echoMsg '!!'    ;
        echo     > $HOME/.ssh/known_hosts ;

        echoMsg '++' Adapted $HOME/.ssh/known_hosts ;
        echoMsg '++' 'known_hosts' ;
        catMe $HOME/.ssh/known_hosts ;
        catMe $HOME/.ssh/known_hosts.old ;
        echoMsg '++' ;
        bundle exec 'rake acceptance:install_module' ;
        echo DONE bundle exec 'rake acceptance:provision_vms acceptance:setup_pe_p2 acceptance:setup_servicenow_instance acceptance:install_module' ;
      
        echoMsg '!!' Ownself install Package Modules    ;
        masterport=2222 ;
        masterip=${pehostnameinservicenow} ;
        
        ls -l pkg/*.tar.gz ;
        tarfile="pkg/*.tar.gz" ;
        btarfile=`basename ${tarfile}`
        scp -i /tmp/myownkey -A -oIdentitiesOnly=yes  -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10 -P${masterport:-2222}   pkg/*.tar.gz  vagrant@${masterip}:/tmp ;
        ssh -i /tmp/myownkey -A -oIdentitiesOnly=yes  -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10 -p${masterport:-2222} -l vagrant ${masterip} "ls -l /tmp/${btarfile} ; sudo puppet module install /tmp/${btarfile} ; " ;
        echoMsg '!!'  ;

        echo ;
        echo ;
        (sleep 1800 && ssh  -i /tmp/myownkey -A -oIdentitiesOnly=yes  -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10  -p${deploype_port} -l vagrant ${deploype_ip}  "rm -fr  /tmp/proxy.txt"  ) &
        echoMsg '==' "Setup done, Now Run Tests"  ;
        bundle exec "rake acceptance:run_tests" ; errorid=$? ;
        echo "rake acceptance:run_tests done with errid=$errorid " ;
        exit $errorid ;
}

function      postcommand(){ # Filed under tear_down__task
        
        #### Hardcoded for now 
        ssh  -i /tmp/myownkey -A -oIdentitiesOnly=yes  -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10   -p${deploype_port} -l vagrant ${deploype_ip}  "rm -fr  /tmp/proxy.txt"  ;
        #### 
        bundle exec "rake acceptance:tear_down"  || echo  "Tear Down also have errors." ;
        
        errorid=$? ;
        exit $errorid ;
}  

function help(){
  echo ;
  echo "Available functions \"$0 exec ....\"  aka :"
  grep function  $0  |  sed -E 's/function[\ ]+/    /'  | tr -d \(\)\{  | grep -v exec | grep -v grep | sort -u ;
  
  echo
  echo
  echo "Available additional functions ( from /tmp/v.sh) \"$0 exec ....\"  aka :"
  [ ! -e /tmp/v.sh ] || grep function  /tmp/v.sh  |  sed -E 's/function[\ ]+/    /'  | tr -d \(\)\{  | grep -v regenfns | grep -v grep | sort -u ;  
}
if [ "help" = "$1"  -o "--help" = "$1"    ] ; then
  help ;
  return 2> /dev/null || true ; exit 0;
fi;
if  [ "exec" = "$1" ] ; then
  shift ;
  echo "===Executing....$@....." ;
  $@ ; errorid=$?;
  echo "==errorid=$errorid=" ;
  return $errorid 2> /dev/null || true ; 
  exit $errorid ;
fi;
exit
=end
}
# lint:endignore
# rubocop:enable all
# puts 'running as ruby'

## Implemented own versions: require_relative './helpers.rb'

module VP
  require 'puppet_litmus'
  PuppetLitmus.configure!

  class Target
    include PuppetLitmus

    attr_reader :uri

    def initialize(uri)
      @uri = uri
    end

    def bolt_config
      inventory_hash = LitmusHelpers.inventory_hash_from_inventory_file
      LitmusHelpers.config_from_node(inventory_hash, @uri)
    end

    # Make sure that ENV['TARGET_HOST'] is set to uri
    # before each PuppetLitmus method call. This makes it
    # so if we have an array of targets, say 'agents', then
    # code like agents.each { |agent| agent.bolt_upload_file(...) }
    # will work as expected. Otherwise if we do this in, say, the
    # constructor, then the code will only work for the agent that
    # most recently set the TARGET_HOST variable.
    PuppetLitmus.instance_methods.each do |name|
      m = PuppetLitmus.instance_method(name)
      define_method(name) do |*args, &block|
        ENV['TARGET_HOST'] = uri
        m.bind(self).call(*args, &block)
      end
    end
  end

  # class TargetNotFoundError < StandardError; end
  module TargetHelpers
    def master
      target('master', 'acceptance:provision_vms', 'master')
    end
    module_function :master

    def servicenow_instance
      target('ServiceNow instance', 'acceptance:setup_servicenow_instance', 'servicenow_instance')
    end
    module_function :servicenow_instance

    def servicenow_host
      target('ServiceNow host', 'valentepuppet:setup_servicenow_host', 'servicenow_host')
    end
    module_function :servicenow_host

    def target(name, setup_task, role)
      @targets ||= {}

      unless @targets[name]
        # Find the target
        inventory_hash = LitmusHelpers.inventory_hash_from_inventory_file '/Users/valente/tmp/m/a.yaml'
        targets = LitmusHelpers.find_targets(inventory_hash, nil)
        target_uri = targets.find do |target|
          vars = LitmusHelpers.vars_from_node(inventory_hash, target) || {}
          roles = vars['roles'] || []
          roles.include?(role)
        end
        unless target_uri
          raise TargetNotFoundError, "none of the targets in 'inventory.yaml' have the '#{role}' role set. Did you forget to run 'rake #{setup_task}'?"
        end
        @targets[name] = Target.new(target_uri)
      end

      @targets[name]
    end
    module_function :target
  end

  module LitmusHelpers
    extend PuppetLitmus
  end
end

namespace :valentepuppet do
  require 'puppet_litmus/rake_tasks'
  require 'English'
  require 'open3'
  # require_relative './helpers'

  include VP::TargetHelpers

  desc 'Testing of Parameters'
  task :parametertests, [:para1, :para2] do |_t, paras|
    # master = VP::Target.new('AAAAAA')
    a = master.uri
    puts "Hello...#{paras[:para1]}...#{paras[:para2]}...#{a}"

    master.run_shell('date')
    master.run_shell('hostname')
    master.run_shell('uptime')
  end

  desc 'PlaceHolder for Skipping'
  task :skipme, [:para1, :para2] do |_t, paras|
    puts "Skipping...with.para1:#{paras[:para1]}...para2:#{paras[:para2]}......"
  end

  # Task For the Standard Breakdown of the Acceptance Test Stages.
  desc 'Provision environment'
  task :provision_environment__task, [:platformprovider, :platforms_image, :docker_runopts] do |_t, paras|
    puts "INPUTS...#{paras}"
    puts 'Provisioning.......... environment'

    ENV['PROVISION_LIST'] = "acceptance_vbox_#{paras[:platforms_image].gsub('litmusimage/', '').gsub(%r{[-.:]}, '_').downcase}" # Set for Provision to pick up
    puts ".......... PROVISION_LIST=#{ENV['PROVISION_LIST']}"
    puts "..........................#{paras[:platforms_image]}===>===#{ENV['PROVISION_LIST']}"
    puts "..........................#{paras[:platformprovider]}===>===vagrant"

    ################# Setup Part1

    cmds = 'bash ./spec/support/acceptance/vhelper.rb exec "runChain + '
    cmds += ' runlogged /tmp/provision.txt +'
    cmds += " runlogged /tmp/provision.txt  echo platforms_image='#{paras[:platforms_image]}'   +"
    cmds += " runlogged /tmp/provision.txt  echo platformprovider='#{paras[:platformprovider]}'   +"
    cmds += ' catMe /tmp/provision.txt  +'
    cmds += ' echoMsg == Prep Install Checks   + installPkg git + chkPkg git curl bash puppet-bolt  +'
    cmds += ' echoMsg == Prep Install Start  + modify_sudo_settings +'
    cmds += ' Create_the_fixtures_directory + echoMsg == Installation of Binary Bolt + install_actual_bolt + echoMsg == Installation of Bolt Modules + install_bolt_modules +'
    cmds += '" 2>&1'
    puts "Executing #{cmds}".gsub('+', "+\n").gsub(%r{password: .+}, 'password: [redacted]')
    output = `#{cmds}`
    if $CHILD_STATUS.success?
      puts output.gsub('\n', "\n").gsub(%r{password: .+}, 'password: [redacted]')
    else
      puts 'SKIPPED abort error: could not execute command for stage 1'
    end

    ################# Setup Part2
    puts "\n\n\n\n\n"
    cmds = 'bash ./spec/support/acceptance/vhelper.rb exec "runChain + '
    cmds += ' echoMsg == PreInstall Checks  + chkPkg git curl bash puppet-bolt  +'
    cmds += ' echoMsg == PreInstall Start +  preinstallpecommands + '
    cmds += '" 2>&1'
    puts "Executing #{cmds}".gsub('+', "+\n").gsub(%r{password: .+}, 'password: [redacted]')
    output = `#{cmds}`
    if $CHILD_STATUS.success?
      puts output.gsub('\n', "\n").gsub(%r{password: .+}, 'password: [redacted]')
    else
      puts 'SKIPPED abort error: could not execute command for stage 2'
    end

    ################# Setup Part3
    puts "\n\n\n\n\n"
    cmds = 'bash ./spec/support/acceptance/vhelper.rb exec "runChain + '
    cmds += ' echoMsg == Install Start  + installpe + '
    cmds += '" 2>&1'
    puts "Executing #{cmds}".gsub('+', "+\n").gsub(%r{password: .+}, 'password: [redacted]')
    output = `#{cmds}`
    if $CHILD_STATUS.success?
      puts output.gsub('\n', "\n").gsub(%r{password: .+}, 'password: [redacted]')
    else
      puts 'SKIPPED abort error: could not execute command for stage 3'
    end

    puts "\n\n\n\n\n"
    puts '==========Installation Done: installpe done. =========================='
    inventoryfile = './spec/fixtures/litmus_inventory.yaml'
    invcontent = ''
    if File.exist?(inventoryfile)
      File.open(inventoryfile, 'r') do |f|
        f.each_line do |line|
          invcontent += line unless %r{^[ ]*#}.match?(line)
        end
      end
      puts "===Actual=Contents=#{inventoryfile}===\n#{invcontent}".gsub(%r{password: .+}, 'password: [redacted]')
    end
    exit 404 if invcontent.empty?
  end

  desc 'Install Puppet agent'
  task :install_agent__task, [:matrix_collection] do |_t, paras|
    puts "INPUTS...#{paras}"
    puts `bash ./spec/support/acceptance/vhelper.rb exec "installpecommands" 2>&1 |  grep -v '.... .......... ....' `.gsub('\n', "\n")
  end

  desc 'Install module'
  task :install_module__task do # , [:para1, :para2] do |_t, paras|
    puts `bash ./spec/support/acceptance/vhelper.rb exec "prepcommand1" `.gsub('\n', "\n").gsub(%r{password: .+}, 'password: [redacted]')
  end

  desc 'Run acceptance tests'
  task :acceptance__task do # , [:para1, :para2] do |_t, paras|
    #    provisiontxtfile = '/tmp/provision.txt'
    #    puts "File.read(#{provisiontxtfile})" if File.exist?(provisiontxtfile)
    #    puts File.read(provisiontxtfile) if File.exist?(provisiontxtfile)
    #
    #    if File.exist?(provisiontxtfile)
    #      if %r{bunutu}.match?(File.read(provisiontxtfile))
    #        puts 'Inside Primary Server as a container: Creating ServiceNow Server.......'
    #        Rake::Task['acceptance:setup_servicenow_instance'].invoke
    #      else
    #        puts 'Inside GitHub Runner as a container: Creating ServiceNow Server.......'
    #        Rake::Task['valentepuppet:setup_servicenow_host'].invoke
    #      end
    #    end

    #    puts 'Testing ServiceNow Server.......'
    #    Rake::Task['acceptance:test_servicenow_host'].invoke

    puts 'Acceptance Test Continues........'
    # Does not show error even when there is an error            puts system('bash', './spec/support/acceptance/vhelper.rb', 'exec', 'command')
    cmd = 'bash ./spec/support/acceptance/vhelper.rb exec command'
    stdin, stdout, stderr, wait_thr = Open3.popen3(cmd)
    puts stdout.read.to_s.gsub('\n', "\n").gsub(%r{password: .+}, 'password: [redacted]')

    if wait_thr.value.success?
      stdin.close
      stdout.close
      stderr.close
      exit(true)
    else
      puts "Error level was: #{wait_thr.value.exitstatus}\n#{stderr.read}".gsub('\n', "\n").gsub(%r{password: .+}, 'password: [redacted]')
      stdin.close
      stdout.close
      stderr.close
      exit wait_thr.value.exitstatus
    end
  end

  desc 'Remove test environment'
  task :tear_down__task do # , [:para1, :para2] do |_t, paras|
    puts `bash ./spec/support/acceptance/vhelper.rb exec "postcommand" `.gsub('\n', "\n").gsub(%r{password: .+}, 'password: [redacted]')
  end
  #
  # end of Rake Tasks
  #
  #
  #
  #
  #
  #
  #
  #
  # ### Litmus Helper
  desc 'Sets up the ServiceNow host'
  task :setup_servicenow_host do
    if File.exist?('inventory.yaml')
      # Check if a servicenow_host docker's already been setup
      begin
        uri = servicenow_instance.uri # an exception occurs here
        puts("A servicenow_instance VM at '#{uri}' has already been set up")
        next
      rescue TargetNotFoundError
        # This means that we haven't set up the servicenow_host docker
        cmd = 'bash ./spec/support/acceptance/vhelper.rb exec setup_servicenow_host ||  true  '
        stdin, stdout, stderr, wait_thr = Open3.popen3(cmd)
        puts stdout.read.to_s.gsub('\n', "\n")

        if wait_thr.value.success?
          puts('  Creating entry for servicenow_instance inventory')
          servicenow_host_uri = 'localhost'
          Rake::Task['acceptance:setup_servicenow_instance'].invoke("#{servicenow_host_uri}:1080", 'mock_user', 'mock_password', 'mock_token', 'setup_servicenow_host_docker')

          stdin.close
          stdout.close
          stderr.close
          exit(true)
        else
          puts "Error level was: #{wait_thr.value.exitstatus}\n#{stderr.read}"
          stdin.close
          stdout.close
          stderr.close
          exit wait_thr.value.exitstatus
        end
      end
    end
    servicenow_host_uri = 'localhost'
    Rake::Task['acceptance:setup_servicenow_instance'].invoke("#{servicenow_host_uri}:1080", 'mock_user', 'mock_password', 'mock_token', 'setup_servicenow_host_docker')
  end

  desc 'Test ServiceNow host with sample Data'
  task :test_servicenow_host do
    cmdb_table = 'cmdb_ci'
    certname_field = 'fqdn'

    testfield = 'location'
    teststring = 'KoKo_NI_ISEKAI_DESU_616'

    fields_template = JSON.parse(File.read('spec/support/acceptance/cmdb_record_template.json'))
    fields_template['attributes'] = cmdb_table
    fields_template[testfield] = teststring
    # rubocop:disable all
    begin
      CMDBHelpers.create_target_record(servicenow_instance, fields_template, table: cmdb_table, certname_field: certname_field)
    rescue
      # This means record exist.
    end
    # rubocop:enable all
    cmdb_record = CMDBHelpers.get_target_record(servicenow_instance)
    CMDBHelpers.delete_target_record(servicenow_instance, table: cmdb_table, certname_field: certname_field)
    h1 = 'TESTING SERVICENOW SERVER'
    puts "#{h1}......cmdb_record['#{testfield}']..should.be.'#{teststring}'.........is.'#{cmdb_record[testfield]}'.(#{(cmdb_record[testfield] == teststring) ? 'same' : 'different'})"
  end

  desc 'Sets up the ServiceNow host with docker'
  task :setup_servicenow_host_docker do
    if File.exist?('inventory.yaml')
      # Check if a servicenow_host docker's already been setup
      begin
        uri = servicenow_host.uri # an exception occurs here
        puts("A servicenow_host VM at '#{uri}' has already been set up")
        next
      rescue TargetNotFoundError
        # This means that we haven't set up the servicenow_host docker
        provision_list = 'acceptance_docker_servicenow'
        Rake::Task['litmus:provision_list'].invoke(provision_list)

        puts("Starting the mock ServiceNow instance at the servicenow_host (#{servicenow_host.uri})")
        servicenow_host.bolt_upload_file('./spec/support/acceptance/servicenow', '/tmp/servicenow')

        ## New Code #
        servicenow_host.bolt_upload_file('./spec/support/acceptance/servicenow/Gemfile', '/tmp/servicenow')
        servicenow_host.bolt_upload_file('./spec/support/acceptance/servicenow/mock_instance.rb', '/tmp/servicenow')
        servicenow_host.bolt_upload_file('./spec/support/acceptance/start_mock_servicenow_instance.sh', '/tmp/servicenow')

        ## Old Code #
        servicenow_host.bolt_run_script('spec/support/acceptance/start_mock_servicenow_instance.sh')
      end
    end
    servicenow_host_uri = servicenow_host.uri.split(':')[0]
    Rake::Task['acceptance:setup_servicenow_instance'].invoke("#{servicenow_host_uri}:1080", 'mock_user', 'mock_password', 'mock_token', 'setup_servicenow_host_docker')
  end
end
