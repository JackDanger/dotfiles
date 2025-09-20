#!/usr/bin/env python3
import os
import pwd
import grp

# Build UID and GID maps: shifted -> real
uid_map = {100000 + u.pw_uid: u.pw_uid for u in pwd.getpwall()}
gid_map = {100000 + g.gr_gid: g.gr_gid for g in grp.getgrall()}

for root, dirs, files in os.walk("/", topdown=True, followlinks=False):
    # Don't cross filesystems
    try:
        st_root = os.lstat(root)
        if os.path.ismount(root) and root != "/":
            continue
    except FileNotFoundError:
        continue

    for name in files + dirs:
        path = os.path.join(root, name)
        try:
            st = os.lstat(path)
        except FileNotFoundError:
            continue

        # Fix owner if in map
        if st.st_uid in uid_map:
            try:
                os.lchown(path, uid_map[st.st_uid], -1)
            except PermissionError:
                pass

        # Fix group if in map
        if st.st_gid in gid_map:
            try:
                os.lchown(path, -1, gid_map[st.st_gid])
            except PermissionError:
                pass
