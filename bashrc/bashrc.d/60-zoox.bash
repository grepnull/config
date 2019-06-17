if [ -z "$MAC_NAME" ]; then
    source ~/driving/scripts/shell/zooxrc.sh
fi

# So our k8s setup doesn't try to launch a browser
export NO_LOCAL_WEBSERVER=1
