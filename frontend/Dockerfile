FROM node:14.15.4-alpine

ENV APP_ROOT /home/node/app

RUN apk add --update --no-cache git yarn imagemagick nano

RUN mkdir -p $APP_ROOT/node_modules && chown -R node:node $APP_ROOT

WORKDIR $APP_ROOT

COPY package*.json $APP_ROOT

RUN npm install

COPY . .

COPY --chown=node:node . $APP_ROOT

USER node

EXPOSE 3000