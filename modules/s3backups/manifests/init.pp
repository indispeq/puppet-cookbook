class s3backups::install {
	#install s3cmd
	#configure with S3 creds (write-only bucket, preferably)
	#in the future maybe have the module create the S3 write-only bucket user
	#install gpg
	#set up gpg key from file
}

class s3backups::jobs {
	#set up cron jobs and targets, have jobs write to bucket subfolders named
	#by date and content type
}
