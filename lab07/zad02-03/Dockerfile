FROM node:alpine

WORKDIR /app

COPY . .

RUN cd server/ && npm install

EXPOSE 3003

WORKDIR /app/server

CMD ["npm", "start"]