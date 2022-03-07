```yaml
---
# This example is based on the example in sudoers(5)
sudo::conf:
  example:
    defaults:
      - Defaults:
          - env_reset
          - syslog=auth
      - Defaults:
          - 'env_keep =  "COLORS DISPLAY HOSTNAME HISTSIZE KDEDIR LS_COLORS"'
      - Defaults:
          - 'env_keep += "MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS LC_CTYPE"'
      - Defaults:
          - 'env_keep += "LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES"'
      - Defaults:
          - 'env_keep += "LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE"'
      - Defaults:
          - 'env_keep += "LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY"'
      - Defaults>root:
          - '!set_logname'
      - Defaults:FULLTIMERS:
          - '!lecture'
      - Defaults:millert:
          - '!authenticate'
      - Defaults@SERVERS:
          - log_year
          - logfile=/var/log/sudo.log
      - 'Defaults!PAGERS':
          - noexec

    user_alias:
      FULLTIMERS:
        - millert
        - mikef
        - dowdy
      PARTTIMERS:
        - bostley
        - jwfox
        - crawl
      WEBMASTERS:
        - will
        - wendy
        - wim
    runas_alias:
      OP:
        - root
        - operator
      DB:
        - oracle
        - sybase
      ADMINGRP:
        - adm
        - oper
    host_alias:
      SPARC:
        - bigtime
        - eclipse
        - moet
        - anchor
      SGI:
        - grolsch
        - dandelion
        - black
      ALPHA:
        - widget
        - thalamus
        - foobar
      HPPA:
        - boa
        - nag
        - python
      CUNETS:
        - 128.138.0.0/255.255.0.0
      CSNETS:
        - 128.138.243.0
        - 128.138.204.0/24
        - 128.138.242.0
      SERVERS:
        - primary
        - mail
        - www
        - ns
      CDROM:
        - orion
        - perseus
        - hercules
    cmnd_alias:
      DUMPS:
        - /usr/bin/mt
        - /usr/sbin/dump
        - /usr/sbin/rdump
        - /usr/sbin/restore
        - /usr/sbin/rrestore
        # yamllint disable-line rule:line-length
        - sha224:0GomF8mNN3wlDt1HD9XldjJ3SNgpFdbjO1+NsQ== /home/operator/bin/start_backups
      KILL:
        - /usr/bin/kill
      PRINTING:
        - /usr/sbin/lpc
        - /usr/bin/lprm
      SHUTDOWN:
        - /usr/sbin/shutdown
      HALT:
        - /usr/sbin/halt
      REBOOT:
        - /usr/sbin/reboot
      SHELLS:
        - /usr/bin/sh
        - /usr/bin/csh
        - /usr/bin/ksh
        - /usr/local/bin/tcsh
        - /usr/bin/rsh
        - /usr/local/bin/zsh
      SU:
        - /usr/bin/su
      PAGERS:
        - /usr/bin/more
        - /usr/bin/pg
        - /usr/bin/less
    user_specs:
      - users:
          - root
        runas:
          users:
            - ALL
      - users:
          - '%wheel'
        runas:
          users:
            - ALL
      - users:
          - FULLTIMERS
        options:
          - 'NOPASSWD:'
      - users:
          - PARTTIMERS
      - users:
          - jack
        hosts:
          - CSNETS
      - users:
          - lisa
        hosts:
          - CUNETS
      - users:
          - operator
        commands:
          - DUMPS
          - KILL
          - SHUTDOWN
          - HALT
          - REBOOT
          - PRINTING
          - sudoedit /etc/printcap
          - /usr/oper/bin/
      - users:
          - joe
        commands:
          - /usr/bin/su operator
      - users:
          - pete
        hosts:
          - HPPA
        commands:
          - '/usr/bin/passwd [A-Za-z]*'
          - '!/usr/bin/passwd *root*'
      - users:
          - '%opers'
        runas:
          groups:
            - ADMINGRP
        commands:
          - /usr/sbin
      - users:
          - bob
        hosts:
          - SPARC
          - SGI
        runas:
          users:
            - OP
      - users:
          - jim
        hosts:
          - '+biglab'
      - users:
          - '+secretaries'
        commands:
          - PRINTING
          - /usr/bin/adduser
          - /usr/bin/rmuser
      - users:
          - fred
        runas:
          users:
            - DB
        options:
          - 'NOPASSWD:'
      - users:
          - john
        hosts:
          - ALPHA
        commands:
          - '/usr/bin/su [!-]*'
          - '!/usr/bin/su *root*'
      - users:
          - jen
        hosts:
          - ALL
          - '!SERVERS'
      - users:
          - jill
        hosts:
          - SERVERS
        commands:
          - /usr/bin/
          - '!SU'
          - '!SHELLS'
      - users:
          - steve
        hosts:
          - CSNETS
        runas:
          users:
            - operator
        commands:
          - /usr/local/op_commands/
      - users:
          - matt
        hosts:
          - valkyrie
        commands:
          - KILL
      - users:
          - WEBMASTERS
        hosts:
          - www
        runas:
          users:
            - www
      - users:
          - WEBMASTERS
        hosts:
          - www
        runas:
          users:
            - root
          commands:
            - /usr/bin/su www
      - users:
          - ALL
        hosts:
          - CDROM
        options:
          - 'NOPASSWD:'
        commands:
          - /sbin/umount /CDROM
          - '/sbin/mount -o nosuid\,nodev /dev/cd0a /CDROM'
```
