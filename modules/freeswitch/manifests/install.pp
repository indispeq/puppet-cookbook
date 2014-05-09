class freeswitch::install ($source_file) {
	file { 'freeswitch-source':

	}

	exec { 'install-freeswitch':
		require => File['freeswitch-source'],
		cwd => '/usr/src',
		command => '/bin/tar/xjzf $source_file && cd source_file_no_tar_bz2 && ./configure && make && make install',
		creates => '/usr/local/bin/freewswitch',
		timeout => 0,
	}
}
