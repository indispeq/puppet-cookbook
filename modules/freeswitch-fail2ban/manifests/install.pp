class freeswitch-fail2ban::install {

	package { 'fail2ban':
		require => Package ['epel-release'],
		ensure => installed,
	}
}
