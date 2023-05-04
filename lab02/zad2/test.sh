#!/bin/bash

docker ps | grep node-express-app-container > /dev/null
if [ $? -eq 0 ]; then
  echo "Kontener Docker jest uruchomiony."
else
  echo "Kontener Docker nie jest uruchomiony."
  exit 1
fi

response=$(curl --write-out '%{http_code}' --silent --output /dev/null http://localhost:8080)

if [[ "$response" -eq 200 ]]; then
  echo "Serwer HTTP działa poprawnie"
else
  echo "Serwer HTTP zwraca nieoczekiwany wynik"
fi

docker stop node-express-app-container
docker rm node-express-app-container

echo "Testy zakończone pomyślnie."
