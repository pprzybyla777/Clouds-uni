#!/bin/bash

docker pull nginx:latest

mkdir nginx-html 

cd nginx-html 

touch index.html

# aby zmienić zawartość strony należy zmodyfikować zawartość w pliku index.html i odświeżyć stronę

echo "<html><body><h1>Witaj w serwerze Nginx!</h1></body></html>" >> index.html

docker run --name moj-nginx -p 8000:80 -d  \
-v /home/pprzybyla/Pulpit/4sem/labs/clouds/lab03/zad01/nginx-html:/usr/share/nginx/html --rm nginx 