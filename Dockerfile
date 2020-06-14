# Dockerfile to run on Production env, which use multiple-step file process
# Idea is to build the  node project and then run them on out nginx webserver.
# so we need two different image(process) one for node & other for nginx
# Idea is to get multi-phase images.

FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html