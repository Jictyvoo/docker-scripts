export YACHT_CONTAINER_NAME=yacht-docker-dashboard
# Pull image and run it

docker pull selfhostedpro/yacht:latest

docker volume create yacht

docker run -d \
    --name $YACHT_CONTAINER_NAME \
    --restart unless-stopped \
    --publish 8888:8000 \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume yacht:/config \
    selfhostedpro/yacht:latest
