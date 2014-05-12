class freeswitch::logging {

	#add config here for logrotate
	#keep x amount of logs, ship the rest to S3 bucket
	#using same user as for backups to a s3://bucket/logs/$DATE$ target
	#to be fancy , use cli to set lifecycle policy on bucket to ship to glacier after x
	#amount of time.

	#also set global freeswitch parameters for logging vebosity

}
