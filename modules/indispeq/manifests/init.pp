class indispeq {
	tag('provisioning')

	# Allow users belonging wheel group to use sudo
	augeas { 'sudowheel':
	    context => '/files/etc/sudoers', # target file is /etc/sudoers
	    changes => [
        	# allow wheel users to use sudo
	        'set spec[user = "%wheel"]/user %wheel',
	        'set spec[user = "%wheel"]/host_group/host ALL',
	        'set spec[user = "%wheel"]/host_group/command ALL',
	        'set spec[user = "%wheel"]/host_group/command/runas_user ALL',
	    ]
	}

	#make sure ssh is running
	#
	#MAY NEED TO ADD PACKAGE INSTALLER HERE BASED ON OS
	#
	service { 'sshd' :
		ensure => running,
		enable => true,
	}

	#secure SSH
	augeas { "sshd_config":
		context => "/files/etc/ssh/sshd_config",
		changes => [
			"set PermitRootLogin no",
			"set PasswordAuthentication no",
			"set ListenAddress 0.0.0.0",
		],
		notify => Service['sshd'],
	}
}
