class epel {
	#expand this to check for other OS if needed, versions, architecture

	#if operatingsystem == CentOS ; operatingsystemrelease == 6.5 ;
	#operatingsystemmajrelease == 6 ; architecture == x86_64

	package { 'epel-release':
		ensure => installed,
		source => 'http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm',
		name => 'epel-release',
		provider => rpm,
	}
}
