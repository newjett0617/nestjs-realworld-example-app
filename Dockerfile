FROM docker.io/library/node:14-alpine as build
WORKDIR /usr/src/app
COPY . .
RUN npm ci && \
    npm run prestart:prod

FROM docker.io/library/node:14-alpine
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/dist ./dist
COPY . .
RUN npm ci
EXPOSE 3000
CMD [ "node", "index.js" ]
