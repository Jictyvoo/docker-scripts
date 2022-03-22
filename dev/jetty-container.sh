# Docker creating a shared volume, in case of mysql update or delete image
export JETTY_HOME=/srv/jetty
export MYSQL_NETWORK_BRIDGE=default-mysql-bridge
export JETTY_CONTAINER_NAME=jetty-server
# Pull image and run it

docker pull jetty:9-jre8

docker run -d \
    --name $JETTY_CONTAINER_NAME \
    --publish 8080:8080 \
    --volume $JETTY_HOME/webapps/:/var/lib/jetty/webapps/ \
    --volume $JETTY_HOME/etc/timezone:/etc/timezone:Z \
    -e TZ=America/Bahia \
    jetty:9-jre8

docker network connect $MYSQL_NETWORK_BRIDGE $JETTY_CONTAINER_NAME

###############################################################################
# To deploy your application to the / context, use the name ROOT.war,
# the directory name ROOT, or the context file ROOT.xml (case insensitive).
#
# WARNING: To connect to database, is needed to use the correct alias
# that was defined during mysql container creation
###############################################################################
