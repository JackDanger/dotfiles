#!/usr/bin/env python3
import os, pwd, grp

SHIFT = 100000
# real -> shifted maps
uid_map = {u.pw_uid: u.pw_uid + SHIFT for u in pwd.getpwall()}
gid_map = {g.gr_gid: g.gr_gid + SHIFT for g in grp.getgrall()}

# lock to the starting device like -xdev
root = "/"
root_dev = os.lstat(root).st_dev

for cur_root, dirs, files in os.walk(root, topdown=True, followlinks=False):
    # prune dirs on other devices
    for i in range(len(dirs) - 1, -1, -1):
        dpath = os.path.join(cur_root, dirs[i])
        try:
            if os.lstat(dpath).st_dev != root_dev:
                dirs.pop(i)
        except FileNotFoundError:
            dirs.pop(i)

    # act on directory itself
    try:
        st = os.lstat(cur_root)
        new_uid = uid_map.get(st.st_uid, st.st_uid)
        new_gid = gid_map.get(st.st_gid, st.st_gid)
        if new_uid != st.st_uid or new_gid != st.st_gid:
            try:
                os.lchown(cur_root, new_uid if new_uid != st.st_uid else -1,
                                   new_gid if new_gid != st.st_gid else -1)
            except PermissionError:
                pass
    except FileNotFoundError:
        continue

    # act on entries
    for name in files + dirs:
        path = os.path.join(cur_root, name)
        try:
            st = os.lstat(path)
        except FileNotFoundError:
            continue

        new_uid = uid_map.get(st.st_uid, st.st_uid)
        new_gid = gid_map.get(st.st_gid, st.st_gid)

        if new_uid != st.st_uid or new_gid != st.st_gid:
            try:
                os.lchown(path, new_uid if new_uid != st.st_uid else -1,
                               new_gid if new_gid != st.st_gid else -1)
            except PermissionError:
                pass
