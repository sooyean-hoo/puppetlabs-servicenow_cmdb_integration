This exists as a submodule in the original repo: `git@github.com:sooyean-hoo/puppetlabs-servicenow_cmdb_integration.git`  also it is commit as a `doc` branch



## To setup
```bash

git clone git@github.com:sooyean-hoo/puppetlabs-servicenow_cmdb_integration.git
mkdir  ./puppetlabs-servicenow_cmdb_integration/doc
git clone git@github.com:sooyean-hoo/puppetlabs-servicenow_cmdb_integration.git ./puppetlabs-servicenow_cmdb_integration/doc
cd ./puppetlabs-servicenow_cmdb_integration/doc ;
git checkout doc 

git config --add user.name "Hoo Sooyean (何書淵)"
git config --add user.email "Sooyean.hoo@perforce.com"

git reset



```


## Nodes Involved
```bash
defaultadminid=xv.sooyean.hoo@singtel.com
defaultadminpasswd=${defaultadminpasswd:-Welcome@2022}

PEVERSION=${PEVERSION:-2019.8.1}   # 2021.7.3
#domain="sg.singtelgroup.net"


imageid_def=rhel8

#servernames=${servernames:-pupprdmasls001.cloudsg1}
servernames=${servernames:-master}

oldcompilernames="${oldcompilernames:-}"

compilernames_ACTUAL="${compilernames:-\
	prvprdpupls103.nix	prvprdpupls104.nix \
    prvprdpupls203.nix  prvprdpupls204.nix  \
            }"
compilernames="${compilernames:-\
			prvprdpupls103.nix prvprdpupls104.nix  \
            }"
compilernames=""

dbnames="${dbnames:-}"

replicanames="${replicanames:-}"
#replicanames="${replicanames:-}"


#agentnames="awsdb" #             borinterm2peagent02
#agentnames="${agentnames:-prvprdrunls001.nix prvprdpupls004.mom.nix git-sgbss.nix pptdevagtl010.cloudsg1}"
agentnames="${agentnames:- servicenow_instance}"

#loadbalancernames="${loadbalancernames:-prvprdlbsls001.nix  }"

 # prvprdlbsls002.nix

nodes_os="=master=UbuntuServer22.04LTS   \
		  =servicenow_instance=UbuntuServer22.04LTS   \
		  \
"
nodes_insttype=" =pupprdmasls002.cloudsg1=t2.2xlarge \
				 =PUPPET_psedev=t2.2xlarge \
				 =prvprdpupls004.mom.nix=t2.xlarge \
				 =psedev=t2.xlarge \
				 =pptdevagtw002.prnbzjcf0uselnxtzbni41unuf.ix.internal.cloudapp.net=t2.large \
"

nodes_volumesize="	=prvprdpupls002.nix=70  \
					=pupprdmasls002.cloudsg1=100  \
					=PUPPET_psedev=100 \
					=prvprdpupls004.mom.nix=100 \
					=prvprdrunls001.nix=70
	  			    =psedev=100 \
"
```

## Prepare for Tests Run
```bash


my-aws-azure-login; 
rm -fr ./nodes.dat ;  
rm -fr ./registerfiles ./prep* ;    
DEAGENTSFIRST=true  VMCREATE=+   defscript=~/bin/PUPPET_EntConsoleSupport.md   servernames=master  compilernames_=- agentnames=servicenow_instance  INSTALLPE=true    mr run      Nodes.List  Nodes.Setup  AltUpdate

cp -f `./master invs ./servicenow_instance --runasroot`.  ./inventory.yaml
```

## Acceptance Tests Run
```bash
cd ../
bundler  update ; bundler install  ;

defscript=$PWD/README.md    mr run Acceptancetests --show 
defscript=$PWD/README.md    mr run Acceptancetests

```



## PDK Unit Test
```bash
cd ../
bundler  update ; bundler install  ; bundler exec pdk test unit
```