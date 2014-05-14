define freeswitch::firewallinput ($porttype, $portnumber, $action, $servicename = $title) {
#	$line is number of implicit deny (last in INPUT
#	$porttype is tcp,udp,all (?)
#	$portnumber is self-explanatory
	exec { "open_$servicename":
		command => "/sbin/iptables -I INPUT `/sbin/iptables -nL INPUT --line-numbers | tail -1 | cut -d\" \" -f1` -p $porttype -m state --state NEW -m $porttype --dport $portnumber -j $action && /sbin/service iptables save && /sbin/service iptables restart",
		unless => "/sbin/iptables --list-rules INPUT | /bin/grep '\\-A INPUT \\-p $porttype \\-m state \\-\\-state NEW \\-m $porttype \\-\\-dport $portnumber \\-j $action'",
	}
}
