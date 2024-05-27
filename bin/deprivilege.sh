#!/bin/bash
#
# Modify permissions in an LXC container after making it privileged

awk -F : '{print $3}' /etc/passwd | while read uid; do echo " -- User: ${uid}"; find / -uid $(( 100000 + $uid )) -exec chown -h $uid {} \;; done
awk -F : '{print $3}' /etc/group | while read gid; do echo " -- Group: ${gid}"; find / -uid $(( 100000 + $gid )) -exec chgrp -h $gid {} \;; done
