class freeswitch::firewall {
#	$line is number of implicit deny (last in INPUT
#	$type is tcp,udp,all (?)
#	$portnumber is self-explanatory
#       exec { 'open firewall ports':
#               get implicit deny rule on input chain with iptables -nL --line-numbers
#               iptables -I INPUT $line -p $type --dport $portnumber -j ACCEPT
#       }
}
