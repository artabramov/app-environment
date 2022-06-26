# docker data: \\wsl$\docker-desktop-data\version-pack-data\community\docker
# kill vmmem: wsl --shutdown
# run tests (from /app): source /app/venv/bin/activate && python3 -m unittest -v tests.user_model_test

#sudo chmod 666 /var/run/docker.sock
#docker build --no-cache -t app ./app/
docker build --no-cache -t app ./app/
#cp -n ./.env.tmp ./.env.dev
docker-compose --env-file ./.env up -d

#docker exec -d mysql chown -R mysql:mysql /var/log/mysql/

#docker stop kibana
#docker stop redis-commander

#docker exec -d redis chown -R www-data:root /var/log/redis/




