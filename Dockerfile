FROM node:13.12.0-alpine as build

# set working directory
WORKDIR /app

# install app dependencies
COPY package.json ./
#COPY package-lock.json ./
RUN npm install

# add app
COPY . ./

RUN npm run build
#
## start app
#CMD ["npm", "start"]


FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]