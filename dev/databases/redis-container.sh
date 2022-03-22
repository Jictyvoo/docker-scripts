# Pull image and run it

docker pull redis:latest

docker run -d \
  --name redis-cache \
  --restart unless-stopped \
  --publish 6379:6379 \
  redis:latest \
  redis-server --save 120 1 --loglevel warning
