class user::virtual {
	define user_dotfile($user) {
		$source = regsubst($name, "^/home/${user}/.(.*)$", "puppet:///modules/user/${user}-\\1")
		file { $name:
			source => $source,
			owner => $user,
			group => $user,
		}
	}

	define ssh_user($key,$dotfile='',$groups='') {
		user { $name:
			ensure => present,
			managehome => true,
			groups => $groups,
		}

		file { "/home/${name}/.ssh":
			ensure => directory,
			mode => '0700',
			owner => $name,
		}

		ssh_authorized_key { "${name}_key":
			key => $key,
			type => 'ssh-rsa',
			user => $name,
			require => File["/home/${name}/.ssh"],
		}

		if $dotfile {
			$filepath = regsubst($dotfile,'^(.*)$',"/home/${name}/.\\0",'G')
			user_dotfile { $filepath:
				user => $name,
			}
		}
	}

	@ssh_user { 'aron':
		key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC8sz27v+9OGveBidk3ghXKVgtGMU9PficS+NJz+5mCRh0MQKpHIlUHMwfJWQkBpQmvFKqeXGVojAeMO8Nf6BlWqP3jt50Gfi2daVOOh6tP+yPg9yILDqDKaOteAWm0uX7byOYQ0y9LNSEjhncboez8g05jTZsBegpAqIBrNlKOqzdCRKooVsJ0owuqeN0/O29XOG4MKEGJ0ojzdffOJcHiJG4+/T2YN9wYvlxhilBUcE+CFrlUzRHhZsRPTniBWdtSGT3WNSzSHkQsOGly5PXzOiL/L6HcRlYQpEopRFVmQe179mpsu8l6QLG8G9nS+lVtOPGNJ0+3V90JGdELCGi9',
		dotfile => ['forward'],
		groups => ['wheel'], #pass empty array if no groups -- []
	}
}
