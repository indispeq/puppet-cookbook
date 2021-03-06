node 'centos1.indispeq.com' { 
	include indispeq::diagnostics
	include indispeq::security
	include user::virtual
	include user::sysadmins
	include freeswitch::install
	include epel

	#fail2ban keeps adding extra rules to iptables. not cool. disabled for now till I find the problem
	#include fail2ban::install
}

node 'fs1.indispeq.local' {
	include indispeq::puppet 
	include indispeq::diagnostics
	include indispeq::security
	include user::virtual
	include user::sysadmins
	include freeswitch::install
	include epel
}
