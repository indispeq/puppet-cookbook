class indispeq::diagnostics {

	package { 'sysstat':
		ensure => installed,
	}

	service { 'sysstat':
		require => Package['sysstat'],
		enable => true,
		ensure => running,
	}

	#may add parameters to change /etc/sysconfig/sysstat, or whatever ubuntu equivalent, then notify service

}
