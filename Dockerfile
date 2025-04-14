FROM node:18-alpine AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .

FROM node:18-alpine
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app ./

ENV PORT=3000
ENV MUSIC_DIR=music
ENV ADMIN_PASSWORD=admin

EXPOSE $PORT
USER node
CMD [ "npm", "start" ]
