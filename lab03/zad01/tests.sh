#!/bin/bash

# Test 1: Sprawdzamy, czy kontener został utworzony i działa na porcie 80
if [[ $(docker ps --filter "name=moj-nginx" --format "{{.Names}}") != "moj-nginx" ]]; then
    echo "Test 1 nie powiódł się: kontener nie został utworzony"
    exit 1
fi

if [[ $(docker port moj-nginx) != "80/tcp -> 0.0.0.0:8000" ]]; then
    echo "Test 1 nie powiódł się: kontener nie działa na porcie 8000"
    exit 1
fi

echo "Test 1 zakończony sukcesem"