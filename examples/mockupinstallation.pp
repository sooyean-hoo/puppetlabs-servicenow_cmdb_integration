# Prep
$comments=  @(COMMENTS/L)

mkdir -p /etc/puppetlabs/puppet/

cat > /etc/puppetlabs/puppet/servicenow_cmdb.yaml <<__EMD
instance: singteldev.service-now.com
user: puppet_integration
password: InTegrati0n@useR
certname_field: name
factnameinplaceofcertname: host_name
table: cmdb_ci
__EMD


./servicenow.rb pupprdcomls001.cloudsg1.sg.singtelgroup.net

| COMMENTS

service{ pe-puppetserver :
  name => puppet,
}

class{ 'servicenow_cmdb_integration' :
  user => 'puppet_integration' ,
  password =>  'pppp' ,
  instance => 'singteldev.service-now.com',
  factnameinplaceofcertname => hostname ,
  debug => 'YES' ,  
}