#!/bin/bash

cat <<EOF > Dockerfile
FROM node:12
EXPOSE 8080
WORKDIR /app
COPY . .
RUN npm install
CMD ["node", "server.js"]
EOF

cat <<EOF > package.json
{
  "name": "hello-world",
  "version": "1.0.0",
  "description": "A simple Node.js HTTP server",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  }
}
EOF

cat <<EOF > server.js
const http = require('http');
const port = 8080;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello World\n');
});

server.listen(port, () => {
  console.log(`Server running at http://localhost:${port}/`);
});
EOF

docker build -t hello-world .

docker run -dit -p 8080:8080 hello-world

# Testowanie czy kontener jest uruchomiony i działa
docker ps | grep hello-world > /dev/null
if [ $? -eq 0 ]; then
  echo "Kontener Docker jest uruchomiony."
else
  echo "Kontener Docker nie jest uruchomiony."
  exit 1
fi