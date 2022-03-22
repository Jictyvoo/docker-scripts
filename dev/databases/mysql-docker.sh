# Docker creating a shared volume, in case of mysql update or delete image
export MYSQL_HOME=/srv/mysql
export MYSQL_NETWORK_BRIDGE=default-mysql-bridge
export MYSQL_CONTAINER_NAME=mysql-server
# Pull image and run it

docker pull mysql/mysql-server:5.6
###########################################################
# The user is needed to access the database externally,
# because root is only inside container
###########################################################

docker network create $MYSQL_NETWORK_BRIDGE
docker run -d \
  --name $MYSQL_CONTAINER_NAME \
  --restart always \
  --env "MYSQL_ROOT_PASSWORD=admin" \
  --env "MYSQL_ROOT_HOST=%" \
  --env "MYSQL_USER=dba" \
  --env "MYSQL_PASSWORD=db_pass" \
  --volume $MYSQL_HOME/etc:/etc/mysql:Z \
  --volume $MYSQL_HOME/storage:/var/lib/mysql:Z \
  --publish 3306:3306 \
  mysql/mysql-server:5.6 \
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
