#!/bin/bash

docker build -t node-express-app .

docker run -p 8080:8080 --name node-express-app-container node-express-app