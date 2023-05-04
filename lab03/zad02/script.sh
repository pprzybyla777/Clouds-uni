#!/bin/bash

# Aby zmienić port, na którym serwer nasłuchuje lub 
# niestandardowy plik konfiguracyjny, należy zmodyfikować  zmienne $PORT i $CONF_FILE i ponownie uruchomić skrypt.

CONTAINER_NAME="nginx-server"
PORT="80"
CONF_FILE="nginx.conf"

echo "<html><body><h1>Witaj w serwerze Nginx!</h1></body></html>" > index.html

# niestandardowy plik konfiguracyjny
echo "worker_processes  1;
events {
    worker_connections  1024;
}
http {
    server {
        listen $PORT;
        root /usr/share/nginx/html;
        index index.html;
    }
}" > $CONF_FILE

# Tworzymy kontener Docker z serwerem Nginx i przekazujemy niestandardowy plik konfiguracyjny
docker run -d -p $PORT:80 --name $CONTAINER_NAME -v $(pwd)/index.html:/usr/share/nginx/html/index.html -v $(pwd)/$CONF_FILE:/etc/nginx/nginx.conf nginx

# Wyświetlamy informacje o kontenerze
echo "Kontener $CONTAINER_NAME został utworzony i działa na porcie $PORT"

# Wyświetlamy adres IP kontenera
CONTAINER_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CONTAINER_NAME)
echo "Adres IP kontenera: $CONTAINER_IP"