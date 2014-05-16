class indispeq::puppet {
	file { '/usr/local/bin/papply':
		source => 'puppet:///modules/indispeq/papply.sh',
		mode => '0755',
	}
}
