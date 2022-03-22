# Docker creating a shared volume, in case of postgres update or delete image
export POSTGRES_HOME=/srv/postgres
export POSTGRES_NETWORK_BRIDGE=default-postgres-bridge
export POSTGRES_CONTAINER_NAME=postgres-server
# Pull image and run it

docker pull postgres
###########################################################
# The user is needed to access the database externally,
# because root is only inside container
###########################################################

docker network create $POSTGRES_NETWORK_BRIDGE
docker run -d \
  --name $POSTGRES_CONTAINER_NAME \
  --restart unless-stopped \
  --env "POSTGRES_USER=dba" \
  --env "POSTGRES_PASSWORD=db_pass" \
  --env "PGDATA=/var/lib/postgresql/data/pgdata" \
  --volume $POSTGRES_HOME/data:/var/lib/postgresql/data:Z \
  --publish 5432:5432 \
  postgres

# Create a network bridge to the postgres server,
# being able to connect to this database using the alias `postgresdb`
docker network connect --alias postgresdb $POSTGRES_NETWORK_BRIDGE $POSTGRES_CONTAINER_NAME

######################################################################################################
# After container running, open container cli, and run
# postgres -uroot -padmin
#
# GRANT ALL PRIVILEGES ON *.* TO 'dba'@'%';
# FLUSH PRIVILEGES;
# QUIT;
######################################################################################################
