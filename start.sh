docker build --no-cache -t app ./app/
#cp -n ./.env.tmp ./.env.dev
docker-compose --env-file ./.env up -d

#docker exec -d app bash -c "source /app/venv/bin/activate && celery -A app.core.worker.celery worker -Q celery --loglevel=info"
