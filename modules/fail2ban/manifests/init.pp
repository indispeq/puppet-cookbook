class fail2ban::install {

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

class fail2ban::freeswitch {
	#augeas the jail.local file?
}

class fail2ban::ssh {
	#remember to lock down SSH on this bad boy w/ fail2ban, maybe with
	#augeas config changes -- this will be tricky -- maybe manipulate
	#a virtual resource ahead of time before realizing it.
}
