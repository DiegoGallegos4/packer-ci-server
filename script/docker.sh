echo -e "\n--- Updating packages list ---\n"
apt-get -qq update

echo -e "\n--- Installing base packages ---\n"
apt-get -y install curl apt-transport-https ca-certificates > /dev/null 2>&1

echo -e "\n--- Add GPG key ---\n"
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D > /dev/null 2>&1

echo -e "\n--- Adding Docker Repo ---\n"
cat > /etc/apt/sources.list.d/docker.list <<EOF
  deb https://apt.dockerproject.org/repo debian-jessie main
EOF

apt-get -qq update

echo -e "\n--- Installing Docker ---\n"
apt-get install docker-engine > /dev/null 2>&1
sudo systemctl start docker > /dev/null 2>&1

# echo -e "\n--- gitlab-postgresql ---\n"
# docker run --name gitlab-postgresql -d \
#     --env 'DB_NAME=gitlabhq_production' \
#     --env 'DB_USER=gitlab' --env 'DB_PASS=password' \
#     --volume /srv/docker/gitlab/postgresql:/var/lib/postgresql \
#     sameersbn/postgresql:9.4-14 > /dev/null 2>&1

# echo -e "\n--- gitlab-redis ---\n"
# docker run --name gitlab-redis -d \
#     --volume /srv/docker/gitlab/redis:/var/lib/redis \
#     sameersbn/redis:latest > /dev/null 2>&1

# echo -e "\n--- gitlab ---\n"
# docker run --name gitlab -d \
#     --link gitlab-postgresql:postgresql --link gitlab-redis:redisio \
#     --publish 10022:22 --publish 10080:80 \
#     --env 'GITLAB_PORT=10080' --env 'GITLAB_SSH_PORT=10022' \
#     --env 'GITLAB_SECRETS_DB_KEY_BASE=long-and-random-alpha-numeric-string' \
#     --volume /srv/docker/gitlab/gitlab:/home/git/data \
#     sameersbn/gitlab:8.5.5 > /dev/null 2>&1

