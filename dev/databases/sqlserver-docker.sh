# Docker creating a shared volume, in case of sqlserver update or delete image
export SQLSERVER_HOME=/srv/sqlserver
export SQLSERVER_NETWORK_BRIDGE=default-sqlserver-bridge
export SQLSERVER_CONTAINER_NAME=sqlserver-2019db_server
# Pull image and run it

docker pull mcr.microsoft.com/mssql/server:latest
###########################################################
# The user is needed to access the database externally,
# because root is only inside container
###########################################################

docker network create $SQLSERVER_NETWORK_BRIDGE
docker run -d \
  --name $SQLSERVER_CONTAINER_NAME \
  --restart unless-stopped \
  --env "SA_PASSWORD=gogo@DMIN1!" \
  --env "MSSQL_PID=Developer" \
  --env "ACCEPT_EULA=Y" \
  --user root \
  --volume $SQLSERVER_HOME/data:/var/opt/mssql/data:Z \
  --volume $SQLSERVER_HOME/log:/var/opt/mssql/log:Z \
  --volume $SQLSERVER_HOME/secrets:/var/opt/mssql/secrets:Z \
  --publish 1433:1433 \
  mcr.microsoft.com/mssql/server:latest

# Create a network bridge to the sqlserver server,
# being able to connect to this database using the alias `sqlserverdb`
docker network connect --alias sqlserverdb $SQLSERVER_NETWORK_BRIDGE $SQLSERVER_CONTAINER_NAME
