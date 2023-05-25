FROM node:alpine

WORKDIR /app

COPY . .

RUN npm install

EXPOSE 3003

WORKDIR /app/server

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
CMD curl -f http://localhost:3000/products || exit 1

CMD ["npm", "start"]