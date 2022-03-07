```
## Managed by puppet class sudo
## Do not edit

# Override built-in defaults
Defaults env_reset, syslog=auth
Defaults env_keep =  "COLORS DISPLAY HOSTNAME HISTSIZE KDEDIR LS_COLORS"
Defaults env_keep += "MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS LC_CTYPE"
Defaults env_keep += "LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES"
Defaults env_keep += "LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE"
Defaults env_keep += "LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY"
Defaults>root !set_logname
Defaults:FULLTIMERS !lecture
Defaults:millert !authenticate
Defaults@SERVERS log_year, logfile=/var/log/sudo.log
Defaults!PAGERS noexec

# User alias specification
User_Alias FULLTIMERS = millert, mikef, dowdy
User_Alias PARTTIMERS = bostley, jwfox, crawl
User_Alias WEBMASTERS = will, wendy, wim

# Runas alias specification
Runas_Alias OP = root, operator
Runas_Alias DB = oracle, sybase
Runas_Alias ADMINGRP = adm, oper

# Host alias specification
Host_Alias SPARC = bigtime, eclipse, moet, anchor
Host_Alias SGI = grolsch, dandelion, black
Host_Alias ALPHA = widget, thalamus, foobar
Host_Alias HPPA = boa, nag, python
Host_Alias CUNETS = 128.138.0.0/255.255.0.0
Host_Alias CSNETS = 128.138.243.0, 128.138.204.0/24, 128.138.242.0
Host_Alias SERVERS = primary, mail, www, ns
Host_Alias CDROM = orion, perseus, hercules

# Cmnd alias specification
Cmnd_Alias DUMPS = /usr/bin/mt, /usr/sbin/dump, /usr/sbin/rdump, /usr/sbin/restore, /usr/sbin/rrestore, sha224:0GomF8mNN3wlDt1HD9XldjJ3SNgpFdbjO1+NsQ== /home/operator/bin/start_backups
Cmnd_Alias KILL = /usr/bin/kill
Cmnd_Alias PRINTING = /usr/sbin/lpc, /usr/bin/lprm
Cmnd_Alias SHUTDOWN = /usr/sbin/shutdown
Cmnd_Alias HALT = /usr/sbin/halt
Cmnd_Alias REBOOT = /usr/sbin/reboot
Cmnd_Alias SHELLS = /usr/bin/sh, /usr/bin/csh, /usr/bin/ksh, /usr/local/bin/tcsh, /usr/bin/rsh, /usr/local/bin/zsh
Cmnd_Alias SU = /usr/bin/su
Cmnd_Alias PAGERS = /usr/bin/more, /usr/bin/pg, /usr/bin/less

# User specification
root ALL = (ALL)  ALL
%wheel ALL = (ALL)  ALL
FULLTIMERS ALL = NOPASSWD: ALL
PARTTIMERS ALL =  ALL
jack CSNETS =  ALL
lisa CUNETS =  ALL
operator ALL =  DUMPS, KILL, SHUTDOWN, HALT, REBOOT, PRINTING, sudoedit /etc/printcap, /usr/oper/bin/
joe ALL =  /usr/bin/su operator
pete HPPA =  /usr/bin/passwd [A-Za-z]*, !/usr/bin/passwd *root*
%opers ALL = (:ADMINGRP)  /usr/sbin
bob SPARC,SGI = (OP)  ALL
jim +biglab =  ALL
+secretaries ALL =  PRINTING, /usr/bin/adduser, /usr/bin/rmuser
fred ALL = (DB) NOPASSWD: ALL
john ALPHA =  /usr/bin/su [!-]*, !/usr/bin/su *root*
jen ALL,!SERVERS =  ALL
jill SERVERS =  /usr/bin/, !SU, !SHELLS
steve CSNETS = (operator)  /usr/local/op_commands/
matt valkyrie =  KILL
WEBMASTERS www = (www)  ALL
WEBMASTERS www = (root)  ALL
ALL CDROM = NOPASSWD: /sbin/umount /CDROM, /sbin/mount -o nosuid\,nodev /dev/cd0a /CDROM
```
