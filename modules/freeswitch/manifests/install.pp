class freeswitch::install {

	#need debian prereq packages as default
	$required_packages = $osfamily ? {
        	RedHat  => ["autoconf","automake","gcc-c++","git-core","libjpeg-devel","libtool","make","ncurses-devel","pkgconfig","unixODBC-devel","openssl-devel","libogg-devel","libvorbis-devel","libcurl-devel","libtiff-devel","python-devel","expat-devel","zlib","zlib-devel","bzip2","which","pcre","pcre-devel","speex-devel","sqlite-devel"],
        	default => ['just','a','bunch','of','nonsense'],
    	}

	package { $required_packages:
        	ensure => "present",
	}

	file { '/tmp/modules.conf':
		require => Package[$required_packages],
		source => 'puppet:///modules/freeswitch/modules.conf',
	}->

	exec { 'compilation':
		cwd => '/usr/local/src',
		command => '/usr/bin/git clone -b v1.2.stable git://git.freeswitch.org/freeswitch.git && cd freeswitch && ./bootstrap.sh && cp /tmp/modules.conf ./ && ./configure -C && /usr/bin/make && /usr/bin/make install && /usr/bin/make cd-sounds-install && /usr/bin/make cd-moh-install',
		creates => '/usr/local/freeswitch',
		timeout => 0,
	}->

	file{ '/usr/local/freeswitch':
		require => User['freeswitch'],
		ensure => directory,
		owner => freeswitch,
		group => freeswitch,
		recurse => true,
	}

	user { 'freeswitch':
		ensure => present,
		system => true,
	}

	file { '/etc/init.d/freeswitch':
		require => File['/usr/local/freeswitch'],
		source => 'puppet:///modules/freeswitch/freeswitch.init.redhat',
		mode => '0755',
		owner => 'root',
		group => 'root',
	}

	service { 'freeswitch':
		hasstatus => true,
		require => File['/etc/init.d/freeswitch'],
		enable => true,
		ensure => running,
	}

#	exec { 'open firewall ports':
#		require => Service['freeswitch'],
#		use a function or definition from firewall.pp, get 5060,5080,
#		and any others.
#		get implicit deny rule on input chain with iptables -nL --line-numbers
#		iptables -I INPUT $line -p tcp --dport 5060 -j ACCEPT
#		iptables -I INPUT $line -p tcp --dport 5060 -j ACCEPT
#	}

	file { '/usr/local/bin/fs_cli':
		require => File['/usr/local/freeswitch'],
		target => '/usr/local/freeswitch/bin/fs_cli',
		ensure => link,
	}

	#A change by Red Hat in RHEL 6 and later releases was to compile the
	#kernel to run tickless by default. As previously brought up on the mailing
	#lists, it is recommended that the kernel's tickless feature should be disabled
	#for optimum performance when running FreeSwitch under the newer operating
	#system's kernel. You can disable the tickless feature by appending nohz=off
	#to your boot options under GRUB. The GRUB start up configuration file is
	#located under /boot/grub or as /etc/grub.conf. Add it to the line beginning
	#with "kernel". This is also applicable to Fedora releases 8 and later.

	#If seeing performance issues, will need to append this

}

