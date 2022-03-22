# docker stack deploy --compose-file docker-compose.yml mystack
# docker-compose up -d
export GITLAB_HOME=/srv/gitlab

docker run --detach \
  --hostname gitlab.example.com \
  --publish 443:443 --publish 80:80 --publish 22:22 \
  --name gitlab \
  --restart always \
  --volume $GITLAB_HOME/config:/etc/gitlab:Z \
  --volume $GITLAB_HOME/logs:/var/log/gitlab:Z \
  --volume $GITLAB_HOME/data:/var/opt/gitlab:Z \
  gitlab/gitlab-ce:13.9.0-ce.0
