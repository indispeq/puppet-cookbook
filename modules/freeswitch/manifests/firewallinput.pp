define freeswitch::firewallinput ($porttype, $portnumber, $action) {
#	$line is number of implicit deny (last in INPUT
#	$porttype is tcp,udp,all (?)
#	$portnumber is self-explanatory
	exec { "open_firewall_ports":
		command => "/sbin/iptables -I INPUT `/sbin/iptables -nL INPUT --line-numbers | tail -1 | cut -d\" \" -f1` -p $porttype --dport $portnumber -j $action",
#		unless => "/sbin/iptables --list-rules INPUT | /bin/grep \'\\-A INPUT \\-p $porttype \\-m tcp $porttype \\-\\-dport $portnumber \\-j $action\'",
		unless => "/bin/grep 'CentOS' /etc/issue",
	}

	exec { "save_iptables":
		#require => Exec["open_firewall_ports"],
		#onlyif => Exec["open_firewall_ports"],
		command => "/sbin/service iptables save",
	}

	exec { "restart_iptables":
		#require => Exec["save_iptables"],
		#onlyif => Exec["save_iptables"],
		command => "/sbin/service iptables restart",
	}
}
