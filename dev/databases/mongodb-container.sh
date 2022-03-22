# Docker creating a shared volume, in case of mongodb update or delete image
export MONGODB_HOME=/srv/mongodb

# Pull image and run it

docker pull mongo:latest
###########################################################
# The `:Z` option is to grant all permissions to volume
###########################################################

docker run -d \
  --name mongodb \
  --restart unless-stopped \
  --volume $MONGODB_HOME/data:/data/db:Z \
  --publish 27017:27017 \
  mongo:latest
