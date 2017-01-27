#!/bin/sh -
### BEGIN INIT INFO
# Provides:          NzbDrone
# Required-Start:    $local_fs $network $remote_fs
# Required-Stop:     $local_fs $network $remote_fs
# Should-Start:      $NetworkManager
# Should-Stop:       $NetworkManager
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts instance of Sonarr
# Description:       starts instance of Sonarr using start-stop-daemon
### END INIT INFO

############### EDIT ME ##################
# path to app
APP_PATH=/opt/NzbDrone

# user
RUN_AS=plex

# path to mono bin
DAEMON=/usr/bin/mono

# options for mono
DAEMON_OPTS=""

# Path to store PID file
PID_PATH=/var/run/nzbdrone
############### END EDIT ME ##################
mkdir -p ${PID_PATH}
PID_FILE=${PID_PATH}/nzbdrone.pid
EXENAME=`basename ${APP_PATH}/NzbDrone.exe`
DESC=`basename ${APP_PATH}/NzbDrone.exe .exe`
NZBDRONE_PID=`ps auxf | grep $EXENAME | grep -v grep | awk '{print $2}'`

test -x $DAEMON || { echo "$DAEMON must be executable."; exit 1; }

set -e

echo $NZBDRONE_PID > $PID_FILE

case "$1" in
start)
    if [ -z "${NZBDRONE_PID}" ]; then
        echo "Starting $DESC"
        rm ${PID_FILE} || return 1
        install -d --mode=0755 -o $RUN_AS $PID_PATH || return 1
        start-stop-daemon -d $APP_PATH -c $RUN_AS --start --background --pidfile $PID_FILE --exec $DAEMON -- $DAEMON_OPTS $EXENAME
    else
        echo "${DESC} already running."
    fi
    ;;
stop)
    echo "Stopping $DESC"
    echo $NZBDRONE_PID > $PID_FILE
    start-stop-daemon --stop --pidfile $PID_FILE --retry 15
    ;;

restart|force-reload)
    echo "Restarting $DESC"
    start-stop-daemon --stop --pidfile $PID_FILE --retry 15
    start-stop-daemon -d $APP_PATH -c $RUN_AS --start --background --pidfile $PID_FILE --exec $DAEMON -- $DAEMON_OPTS $EXENAME
    ;;
*)
     echo "Usage: `basename $0` {start|stop|restart|force-reload}" >&2
     exit 1
    ;;

esac

exit 0
