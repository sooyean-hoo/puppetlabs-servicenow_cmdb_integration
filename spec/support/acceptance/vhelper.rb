# lint:ignore:all
# rubocop:disable all
print(){
=begin
}
#echo 'running as shell'

  ( sudo apt install -y curl || sudo yum install -y curl || apt install -y curl || yum install -y curl ) &&
  curl -q "https://raw.githubusercontent.com/sooyean-hoo/pe_curl_requests/feature/SYInstallerEnhance/installer/download_pe_tarball.sh"  > /tmp/v.sh  || which curl ;
  source /tmp/v.sh  loadlib  ;
  VAGRANTRUN="Y" ;
  
      deploy_peversion='2021.7.8' ;
      deploy_petarget='127.0.0.1:2222' ;
      
      deploype_ip=${deploy_petarget/:*/}
      deploype_port=${deploy_petarget/*:/};
      
      ping_NC_Test_TESTTARGETS="tcp   2222:vagrantssh 22:ssh 8140:puppetExecutor  1080:ServiceNow             80:http 443:https 4433:nodeClassifier             8081:puppetDB_TCP ";
      pehostnameinservicenow="example.puppet.com" ;
      
      
function      preinstallpecommands(){
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
        installPkg $pkgs ;
        echo "=====Pkgs=${vagrantpkgs}=============" ;
        installPkg $vagrantpkgs ;
        echo "=====Pkgs=${snappkgs}=============" ;
        installPkg $snappkgs ;
        vagrant plugin install vagrant-libvirt ;
        vagrant plugin list ;
        wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg ;
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list ; 
        sudo apt update && sudo apt install ${vagrantpkgs} ;     
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
        mkdir -p /home/runner/.ssh ; touch /home/runner/.ssh/known_hosts ; touch  ~/.ssh/known_hosts ;
        echo ;
        echoMsg '__' 'Inventories'
        echo -e '\n  - name: master\n    targets:\n      - uri: localhost\n        vars:\n          roles:\n            - master   >> inventory.yaml' > /dev/null  ; 
        echo -e '\n  - name: servicenow_instance\n    targets:\n      - uri: localhost\n        vars:\n          roles:\n            - servicenow_instance' '>> inventory.yaml' > /dev/null &&
        cat $PWD/inventory.yaml && 
        [ -e $PWD/inventory.yaml  ] && ln -sf $PWD/inventory.yaml $PWD/spec/fixtures/litmus_inventory.yaml ;
        ls -l $PWD/inventory.yaml || echo ;
        ls -l $PWD/spec/fixtures/litmus_inventory.yaml || echo ;
        catMe $PWD/inventory.yaml  || echo ;
        catMe $PWD/spec/fixtures/litmus_inventory.yaml || echo ;
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
          bolt script run -t ssh_nodes ./spec/support/acceptance/vhelper.rb ;
          bolt command run -t ssh_nodes "bash /tmp/v.sh exec installPkg curl " ;
        elif [ "vagrant" =  "$provisioner" ] ; then
          echo "=======VAGRANT RUN=======" ;
          ssh-keygen -t ed25519 -f /tmp/myownkey      -P '' ; grep -H -n -v -E 'AALINEAANUMBER'  /tmp/myownkey* ;
          echo "===Proposed Changes===" ;
          cat ./spec/fixtures/litmus_inventory.yaml | yq  '.groups[].targets[].config.ssh.private-key="/tmp/myownkey"' | tee ./spec/fixtures/litmus_inventory.yaml.proposed | grep -H -n -v -E 'AALINEAANUMBER' ;
          echo "=============================================================" ;
          ls -l /home/runner/.vagrant.d/insecure_private_keys/vagrant.key.ed25519 ;
          ls -l /home/runner/.vagrant.d/insecure_private_keys/ ;
          pwd ; ls -l ; ls -l /home/runner/.vagrant.d/ ; vagrant global-status ;
          OLDCWD=$(pwd) ;
          echo "=====vagrant ssh default===========" ;
          pushd `pwd` ; cd spec/fixtures/.vagrant/generic-ubuntu2204-0 ;pwd ;
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
          echo "===== ssh with vagrantkey ===========" ;
          ssh  -i /home/runner/.vagrant.d/insecure_private_keys/vagrant.key.ed25519 -A -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10 ${sshverbose} -p${deploype_port} -l vagrant ${deploype_ip} date  ||  echo "FAIL: ssh with vagrantkey..."  ;
          echo "===== ssh with /tmp/myownkey ===========" ;
          ssh  -i /tmp/myownkey -A -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10 ${sshverbose} -p${deploype_port} -l vagrant ${deploype_ip} date  ||  echo "FAIL: ssh with /tmp/myownkey..."  ;
          echo "SKIPPED ======ssh puppet install====================" ;
          echo SKIPPED ssh  -i /tmp/myownkey -A -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10 ${sshverbose} -p${deploype_port} -l vagrant ${deploype_ip} "sudo apt install -y puppet"  "||"  echo "FAIL: ssh puppet install..."  ;
          echo "==========================" ;
        else
          echo "=======SKIPPED COS Unsupported provisioner: $provisioner =======" ;
        fi ;
}
function      installpecommands(){
        source /tmp/v.sh  loadlib  ;
        echo "===FailSafe PE Installation, in case the original one fail===" ;
        PEVERSION='2021.7.8' ;
        pepasswd="pie$(date +%s )piepiepiepiepiepiepiepiepieP5!" ;
        puppetversion=`bolt command run "puppet --version" -t ssh_nodes | grep -v ' on ' ` || echo ; 
        version="NOT NEEDED SO ByPassed" ;
        if  [ -z "$version" ] ; then
          echo "===Installing Puppet Version Installed=${PEVERSION} my way===" ;
          apt install -y curl || yum install -y curl ;
          curl -q "https://raw.githubusercontent.com/sooyean-hoo/pe_curl_requests/feature/SYInstallerEnhance/installer/download_pe_tarball.sh"  > /tmp/v.sh ;
          source /tmp/v.sh  loadlib ;
          echo -e "srcgitKey='/tmp/key2share'\ndisplay_local_time=true\nadminpasswd=\"$pepasswd\"" > /tmp/installPEConsole.SETVALUES.txt ;
          touch /tmp/key2share ;
          installPEConsole =SETVALUES= ;
          installPEConsole - =SETVALUES==PRECHECK==UNTAR==PRECONFIG=PRECONFIG2=  ;
          dlPEConsole check ${PEVERSION} ;
          dlPEConsole show ${PEVERSION} ;
          installPEConsole ;
        else
          oldDIR="$PWD" ;
          cd ./spec/fixtures/ ;
          puppetversion=`bolt command run "puppet --version" -t ssh_nodes | grep -v ' on '` || echo ; 
          echo "===Puppet Version Installed=${puppetversion}===" || echo ;
          echoMsg '!!' 'Prepare Primary server aka ssh_nodes for tests: Access Keys' ;
          bolt command run "echo pepasswd='$pepasswd' > /tmp/p.txt" -t ssh_nodes  ;
          ls -l ${oldDIR}/spec/support/acceptance/install_pe.sh ;
          bolt script run ${oldDIR}/spec/support/acceptance/install_pe.sh -t ssh_nodes  ;
        fi ;
}
function      prepcommand1(){
        cd ./spec/fixtures/ ;
        puppetversion=`bolt command run "puppet --version" -t ssh_nodes | grep -v ' on '`  || echo ; 
        echo "===Puppet Version Installed=${puppetversion}===" || echo ;
}
function      command(){
        source /tmp/v.sh  loadlib  ;
        echoMsg '!!' "Running the actual Acceptance Tests" || echo "============================Running the actual Acceptance Tests============================== " ;
        bundle install ;
        bundle exec 'rake --tasks' ;
        bundle install ;
        bundle exec 'rake acceptance:setup_pe_p2' ;
        bundle install ;
        bundle exec 'rake acceptance:setup_servicenow_instance ' ;
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
          cat ./spec/fixtures/litmus_inventory.yaml | sed -E 's/ [^ :]+:2222:1080/ localhost:1080/g' | sed -E 's/name: ([^:]+:2222)/name: master/g' | sed  -E "s/uri: 127.0.0.1:2222/uri: ${pehostnameinservicenow}/g" | sed  -E "s/host: 127.0.0.1/host: ${pehostnameinservicenow}/g"  > ./spec/fixtures/litmus_inventory.yaml.NEW ;
          cat ./spec/fixtures/litmus_inventory.yaml.NEW > ./spec/fixtures/litmus_inventory.yaml ; 
          rm -fr ./spec/fixtures/litmus_inventory.yaml.NEW ;
        else
          echo "=======SKIPPED Adjustment COS Unsupported provisioner: $provisioner =======" ;
        fi ;
        echoMsg '++' "    In Use" ;
        grep -H -n -v -E 'AALINEAANUMBER' ./spec/fixtures/litmus_inventory.yaml ;
        echoMsg '++' 'Connectivity Checks Before  Running the rest'  ;
        echoMeNRun ip addr || echo "IP addr Failed..." ;
        bolt command run "ip addr" -t all |  tee /tmp/ip.txt   || echo "ip addr on nodes" ;  
        masterip=`cat /tmp/ip.txt | grep 10.0.2 | sed -E 's/^.+ (10.0.2.[^\/]+)\/.+$/\1/g'` ;
        
        #### Hardcoded for now 
        masterip=${deploype_ip} ;
        echoMsg '++'    ;
        set | grep -E 'masterip=|_port=|_ip=|^deploype|ipaddrport=|^deploy' | grep -v '^ ' ;
        echoMsg '++'    ;
        ssh  -i /tmp/myownkey -A -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10 ${sshverbose} -p${deploype_port} -l vagrant ${deploype_ip} -L:8140:127.0.0.1:8140 -L:8143:127.0.0.1:8143 -L:1080:127.0.0.1:1080 "grep -H -n -v -E 'AALINEAANUMBER' /etc/puppetlabs/puppet/puppet.conf"  ;
        echoMsg '++'    ;
        ssh  -i /tmp/myownkey -A -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10 ${sshverbose} -p${deploype_port} -l vagrant ${deploype_ip} -L:8140:127.0.0.1:8140 -L:8143:127.0.0.1:8143 -L:1080:127.0.0.1:1080 "touch /tmp/proxy.txt"  ;
        ssh  -i /tmp/myownkey -A -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10 ${sshverbose} -p${deploype_port} -l vagrant ${deploype_ip} -L:8140:127.0.0.1:8140 -L:8143:127.0.0.1:8143 -L:1080:127.0.0.1:1080 "while [ -e /tmp/proxy.txt ] ; do sleep 30 ; done ;  "  &
        sleep 10 ;
        #### 
        cat ./spec/fixtures/litmus_inventory.yaml | grep uri | sed -E 's/^[^:]+://g' | while read ipaddrport ; do 
          masterip=${ipaddrport/:*/} ;
          masterport=${ipaddrport/*:/} ;
          echo ping_NC_Test ${masterip}  tcp ${masterport}:boltinvconnectport ${ping_NC_Test_TESTTARGETS}    ;
          ping_NC_Test ${masterip}       tcp ${masterport}:boltinvconnectport ${ping_NC_Test_TESTTARGETS}  || echo "ping_NC_Test Failed..." ;
        done ;
        whoami ;
        catMe /etc/hosts ;
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
          ssh -i /tmp/myownkey -A -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10  -p${masterport} -l vagrant ${masterip} "echo Working:  vagrant@${masterip}:${masterport}" || echo "Failed:  vagrant@${masterip}:${masterport} ;
          ssh -i /tmp/myownkey -A -oTCPKeepAlive=yes -oServerAliveInterval=10  -p${masterport} -l vagrant ${masterip} "echo Working HostChecked:  vagrant@${masterip}:${masterport}" || echo "Failed HostChecked:  vagrant@${masterip}:${masterport} ;
        done ;
        echoMsg '!!'    ;
        echo     > $HOME/.ssh/known_hosts ;

        echoMsg '++' 'known_hosts' ;
        catMe $HOME/.ssh/known_hosts ;
        catMe $HOME/.ssh/known_hosts.old ;
        echoMsg '++' ;
        bundle exec 'rake acceptance:install_module' ;
        echo DONE bundle exec 'rake acceptance:provision_vms acceptance:setup_pe_p2 acceptance:setup_servicenow_instance acceptance:install_module' ;
      
        echoMsg '!!' Package Modules    ;
        ls -l pkg/*.tar.gz
        echoMsg '!!'  ;

        echo ;
        echo ;
        (sleep 1800 && ssh  -i /tmp/myownkey -A -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10  -p${deploype_port} -l vagrant ${deploype_ip}  "rm -fr  /tmp/proxy.txt"  ) &
        echoMsg '==' "Setup done, Now Run Tests"  ;
        bundle exec 'rake acceptance:run_tests acceptance:tear_down'  ; errorid=$? ;
        #### Hardcoded for now 
        ssh  -i /tmp/myownkey -A -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oTCPKeepAlive=yes -oServerAliveInterval=10   -p${deploype_port} -l vagrant ${deploype_ip}  "rm -fr  /tmp/proxy.txt"  ;
        #### 
        exit $errorid ;
}  
  
if  [ "exec" = "$1" ] ; then
  shift ;
  echo "===Executing....$@....." ;
  $@ ; errorid=$?;
  echo "==errorid=$errorid=" ;
  return; exit $errorid;
fi;
exit
=end
}
# lint:endignore
# rubocop:enable all
# puts 'running as ruby'
require './helpers.rb'

module VHelpers
  extend TargetHelpers
end
