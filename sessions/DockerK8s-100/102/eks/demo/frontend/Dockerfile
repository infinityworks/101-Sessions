# multistage build to create temporary image used
# to build artifact which is then copied to prod image

# build environment
FROM node:latest as buildenv
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . /app
RUN npm run build

# production environment
FROM nginx:1.16.0-alpine
COPY --from=buildenv /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]