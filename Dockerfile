FROM node:19.4-alpine
RUN apk add g++ make py3-pip

# Create app directory
WORKDIR /usr/src/app

COPY package*.json ./

COPY . .

RUN npm ci

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$PATH:/home/node/.npm-global/bin

CMD [ "npm", "run", "start:dev" ]