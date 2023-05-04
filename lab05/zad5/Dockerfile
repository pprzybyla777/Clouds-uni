FROM node AS build
WORKDIR /usr/src/app
COPY . .
RUN npm install --silent
RUN npm run build

FROM nginx
COPY --from=build /usr/src/app/dist /user/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 81
CMD ["nginx", "-g", "daemon off;"]