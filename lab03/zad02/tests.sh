#!/bin/bash

if [[ $(docker ps --filter "name=nginx-server" --format "{{.Names}}") != "nginx-server" ]]; then
    echo "Test 1 nie powiódł się: kontener nie został utworzony"
    exit 1
fi

if [[ $(docker port nginx-server) != "80/tcp -> 0.0.0.0:80" ]]; then
    echo "Test 1 nie powiódł się: kontener nie działa na porcie 80"
    exit 1
fi

echo "Test ukończony pomyślnie!"