FROM node:16-alpine
RUN npm install -g nodemon
EXPOSE 3000
WORKDIR /app
COPY . .
RUN npm install
CMD ["npm", "run", "dev"]