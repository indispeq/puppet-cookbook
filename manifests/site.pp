node 'centos1.indispeq.com' { 
	include indispeq
	include user::virtual
	include user::sysadmins
	include freeswitch::install
	include epel
	include fail2ban::install
}
