#!/bin/bash
PROXY_PORT=10809
WINDOWS_NAMESERVER=`cat /etc/resolv.conf|grep nameserver|awk '{print $2}'`
ALL_PROXY=socks5://$WINDOWS_NAMESERVER:$PROXY_PORT
GIT_HTTP_PROXY=`git config --global --get http.proxy`
GIT_HTTPS_PROXY=`git config --global --get https.proxy`

case $1 in
        start)
            export HTTP_PROXY=$ALL_PROXY
            export HTTPS_PROXY=$ALL_PROXY

            if [ "`git config --global --get http.proxy`" != $ALL_PROXY ]; then
                git config --global http.proxy $ALL_PROXY
                git config --global https.proxy $ALL_PROXY
            fi
            ;;
        stop)
            unset HTTP_PROXY
            unset HTTPS_PROXY

            if [ "`git config --global --get http.proxy`" = $ALL_PROXY ]; then
                git config --global --unset http.proxy
                git config --global --unset https.proxy
            fi
            ;;
        status)
            echo "HTTP_PROXY:" $HTTP_PROXY
            echo "HTTPS_PROXY:" $HTTPS_PROXY
            echo "GIT_HTTP_PROXY: `git config --global --get http.proxy`"
            echo "GIT_HTTPS_PROXY: `git config --global --get https.proxy`"
            ;;
        *)
            echo "usage: source $0 start|stop|status"
            ;;
esac
