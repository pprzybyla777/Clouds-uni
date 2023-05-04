#!/bin/bash

docker build -t node-express-app .

docker run -p 3000:3000 --name node-express-app-container node-express-app