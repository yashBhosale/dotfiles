#!/bin/bash
echo "Starting restic backup" 
source /etc/restic-config/restic-env


flock --nonblock --conflict-exit-code 4 /etc/restic-config/backup.lock restic backup --files-from /etc/restic-config/files-from --exclude-file=/etc/restic-config/excludes --verbose

retval=$?

if [ $retval -eq 4 ]; then
	echo "Restic backup didn't run because there was already a backup taking place"
fi

