class freeswitch::install {
	#need debian prereq packages

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
		require => File['/etc/init.d/freeswitch'],
		enable => true,
		ensure => running,
	}
	#make system service

	#start service

}

