FROM node:22-alpine3.19 AS build
WORKDIR app
COPY package.json .
RUN npm install 
COPY . . 
RUN npm run build

FROM nginx:1.27-alpine3.19
COPY --from=build app/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build app/dist/. /usr/share/nginx/html
