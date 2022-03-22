# Docker creating a shared volume, in case of elasticsearch update or delete image
export ELASTICSEARCH_NETWORK_BRIDGE=default-elasticsearch-bridge
export ELASTICSEARCH_CONTAINER_NAME=elasticsearch
# Pull image and run it

docker pull elasticsearch:7.16.3

docker network create $ELASTICSEARCH_NETWORK_BRIDGE
docker run -d \
  --name $ELASTICSEARCH_CONTAINER_NAME \
  --net $ELASTICSEARCH_NETWORK_BRIDGE \
  --restart unless-stopped \
  --env "discovery.type=single-node" \
  --publish 9200:9200 \
  --publish 9300:9300 \
  elasticsearch:7.16.3
