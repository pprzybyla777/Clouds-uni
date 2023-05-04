#!/bin/bash

# SKRYPT MUSI BYĆ URUCHOMIONY Z KATALOGU W KTÓRYM ZNAJDUJE SIĘ DOCKERFILE WRAZ Z APLIKACJĄ

docker run -d -it -p 27017:27017 --name mongo mongo

# Oczekiwanie na uruchomienie bazy danych MongoDB
echo "Oczekiwanie na uruchomienie bazy danych MongoDB"
until docker exec mongo mongosh --eval "print(\"MongoDB is up\")" &>/dev/null; do
    printf '.'
    sleep 1
done

printf "\n"

# Stworzenie obrazu dla naszej aplikacji

docker build -t node-express-mongo-app .

# Uruchomienie kontenera z aplikacją Node.js i Express.js

 docker run -d -p 8080:8080 --name zad3 \
  -e MONGO_URL=mongodb://host.docker.internal:27017/test \
   --link mongo:host.docker.internal node-express-mongo-app

# Oczekiwanie na uruchomienie kontenera wraz z aplikacją oraz uruchomienie serwera
echo "Oczekiwanie na uruchomienie serwera"

until [[ "$(docker logs --tail 1 zad3 | grep '8080')" ]]; do
    printf '.'
    sleep 1
done

printf "\n"

# Pobranie odpowiedzi z serwera HTTP

response=$(curl --write-out '%{http_code}' --silent --output /dev/null http://localhost:8080/products)

# Sprawdzenie, czy serwer HTTP zwraca oczekiwany wynik

echo "$response"

if [[ "$response" -eq 200 ]]; then
  echo "Serwer HTTP działa poprawnie"
else
  echo "Serwer HTTP zwraca nieoczekiwany wynik"
fi

printf "\n"

res="$(curl -s http://localhost:8080/products)"

echo "$res"

expected_result='[{"price":9.99,"quantity":5,"name":"Product 1","description":"This is the first product in the array"},{"price":19.99,"quantity":10,"name":"Product 2","description":"This is the second product in the array"}]'


if [[ "$res" == "$expected_result" ]]; then
  echo "Test has passed"
else
  echo "Test has failed"
fi

# Zatrzymanie i usunięcie kontenera
docker stop zad3
docker rm zad3