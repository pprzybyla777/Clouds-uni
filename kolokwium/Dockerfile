# first stage
FROM alpine:latest AS build

ARG GIT_REPO="https://github.com/pprzybyla777/sample-react-app.git"

RUN apk --no-cache add curl git 
RUN apk --no-cache add --update nodejs npm

WORKDIR /usr/app

RUN git clone ${GIT_REPO} .
RUN npm install
RUN npm run build

# second stage
FROM nginx:latest

COPY --from=build /usr/app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]