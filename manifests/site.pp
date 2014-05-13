node 'centos1.indispeq.com' { 
	include indispeq::security
	include user::virtual
	include user::sysadmins
	include freeswitch::install
	include epel
	include fail2ban::install
}
