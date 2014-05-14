class indispeq::diagnostics {

	package { 'sysstat':
		ensure => installed,
	}

	#revisit this, am getting a Notice:
	#/Stage[main]/Indispeq::Diagnostics/Service[sysstat]/ensure: ensure changed 'stopped' to 'running', like it's not chkconfig-d
	service { 'sysstat':
		require => Package['sysstat'],
		enable => true,
		ensure => running,
	}

	#may add parameters to change /etc/sysconfig/sysstat, or whatever ubuntu equivalent, then notify service

}
