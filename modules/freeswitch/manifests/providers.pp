class freeswitch::providers {

}

class freeswitch::vitelity {

	#vitelity.xml.erb file

	file { '/usr/local/freeswitch/conf/sip_profiles/external/vitelity.xml':
		#may make sense to parameterize this and store creds in one json or something
		$vitelity_username = '',
		$vitelity_password = '',
		$vitelity_inbound_host = '',
		$vitelity_outbound_host = '',
		content => template('freeswitch/vitelity.xml.erb'),
		mode => 0644,
		owner => freeswitch,
		group => freeswitch,
	}

	#http://wiki.freeswitch.org/wiki/Provider_Configuration:_Vitelity

	#need to probably to a notify, or restart or something. will declare
	#separate globally callable exec resource for it Exec['reload freeswitch']



}

class freeswitch::2600hz {
	#explore these guys too
}
