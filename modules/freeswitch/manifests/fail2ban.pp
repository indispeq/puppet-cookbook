class freeswitch::fail2ban {

	#do this if centos

	package { 'fail2ban':
		require => Package ['epel-release'],
		ensure => installed,
	}

	#do this for ubuntu

	# ----------
	#get config stuff from here
	#https://confluence.freeswitch.org/display/FREESWITCH/Fail2Ban
}
