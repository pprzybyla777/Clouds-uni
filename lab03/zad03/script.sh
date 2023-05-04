#!/bin/bash

docker network create my-network

# uruchamianie kontenera z napisanym prostym serwerem w Express i Node.js
docker run --name my-node-app --network my-network -d node-express-app

echo "http {
  proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=my_cache:10m inactive=60m;
  server {
    listen 80;
    server_name localhost;

    location / {
      proxy_pass http://my-node-app:3000;
      proxy_cache my_cache;
      proxy_cache_valid 200 60m;
    }
  }

  server {
    listen 443 ssl;
    server_name localhost;

    ssl_certificate /etc/nginx/ssl/nginx.crt;
    ssl_certificate_key /etc/nginx/ssl/nginx.key;

    location / {
      proxy_pass http://my-node-app:3000;
      proxy_cache my_cache;
      proxy_cache_valid 200 60m;
    }
  }
}" > nginx.conf

docker run --name my-nginx-container --network my-network -p 80:80 -p 443:443 -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf -v $(pwd)/cache:/var/cache/nginx -v $(pwd)/ssl:/etc/nginx/ssl -d nginx

docker exec my-nginx-container sh -c "mkdir -p /etc/nginx/ssl && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj '/C=US/ST=CA/L=SF/O=MyApp/OU=Engineering/CN=localhost' && cp /etc/nginx/ssl/nginx.crt /etc/nginx/ssl/nginx.key /ssl/"

docker exec my-nginx-container sh -c "nginx -s reload"

