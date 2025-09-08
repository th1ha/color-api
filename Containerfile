FROM node:22-slim as build

WORKDIR /app

COPY package*.json . 

RUN npm ci

COPY src src

FROM node:22-slim

WORKDIR /app

COPY --from=build /app/node_modules node_modules
COPY --from=build /app/package*.json .
COPY --from=build /app/src/ src

EXPOSE 8080

CMD ["npm", "start"]