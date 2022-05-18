# docker data: \\wsl$\docker-desktop-data\version-pack-data\community\docker

sudo chmod 666 /var/run/docker.sock
#docker build --no-cache -t app ./app/
#cp -n ./.env.tmp ./.env.dev
docker-compose --env-file ./.env up -d

docker exec -d mysql chown -R mysql:mysql /var/log/mysql/

docker stop kibana
docker stop redis-commander
docker stop flower

#docker exec -d redis chown -R www-data:root /var/log/redis/
#docker exec -d app bash -c "source /app/venv/bin/activate && celery -A app.core.app_worker.celery worker -Q celery -f /var/log/celery/celery.log --loglevel=info"

# apt-get update && apt-get upgrade -y && apt-get install -y ntp
# ntpd -gq
# service ntp start
# echo Europe/Moscow >/etc/timezone && dpkg-reconfigure -f noninteractive tzdata


