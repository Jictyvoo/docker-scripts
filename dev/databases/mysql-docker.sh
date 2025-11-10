#!/bin/bash
# Docker creating a shared volume, in case of mysql update or delete image

# Load environment variables from .env file if it exists
if [ -f .env ]; then
  export $(cat .env | grep -v '^#' | xargs)
fi

export MYSQL_HOME=/srv/mysql
export MYSQL_NETWORK_BRIDGE=default-mysql-bridge
export MYSQL_CONTAINER_NAME=mysql-server
export MYSQL_USER=dba

# Validate required environment variables
if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
  echo "Error: MYSQL_ROOT_PASSWORD is not set. Please set it in .env file or export it."
  echo "See .env.example for reference."
  exit 1
fi

if [ -z "$MYSQL_PASSWORD" ]; then
  echo "Error: MYSQL_PASSWORD is not set. Please set it in .env file or export it."
  echo "See .env.example for reference."
  exit 1
fi

# Pull image and run it
docker pull mysql/mysql-server:latest
###########################################################
# The user is needed to access the database externally,
# because root is only inside container
###########################################################

docker network create $MYSQL_NETWORK_BRIDGE 2>/dev/null || true
docker run -d \
  --name $MYSQL_CONTAINER_NAME \
  --restart always \
  --env "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" \
  --env "MYSQL_ROOT_HOST=%" \
  --env "MYSQL_USER=$MYSQL_USER" \
  --env "MYSQL_PASSWORD=$MYSQL_PASSWORD" \
  --volume $MYSQL_HOME/etc:/etc/mysql:Z \
  --volume $MYSQL_HOME/storage:/var/lib/mysql:Z \
  --publish 3306:3306 \
  mysql/mysql-server:latest \
  --lower-case-table-names

# Create a network bridge to the mysql server,
# being able to connect to this database using the alias `mysqldb`
docker network connect --alias mysqldb $MYSQL_NETWORK_BRIDGE $MYSQL_CONTAINER_NAME

######################################################################################################
# After container running, open container cli, and run
# mysql -uroot -padmin
# INSERT INTO mysql.user(Host, USER, PASSWORD, ssl_cipher, x509_issuer, x509_subject)
# VALUES ('%', 'admin', '*78C9AB4601BD9136075EA8DBF4B132BACE217480', '', '', '');
#
# GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%';
# GRANT ALL PRIVILEGES ON *.* TO 'dba'@'%';
# FLUSH PRIVILEGES;
# QUIT;
######################################################################################################
