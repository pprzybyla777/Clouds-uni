FROM node:latest

WORKDIR /app

COPY . .

RUN npm install

ENV PORT=8080

EXPOSE $PORT

CMD ["npm", "start"]