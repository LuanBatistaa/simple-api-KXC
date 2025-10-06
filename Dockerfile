
FROM node:20-alpine AS build

RUN apk add --no-cache postgresql-client

WORKDIR /app

COPY package*.json ./

RUN npm install --production

COPY . .

FROM node:20-alpine AS production

RUN apk add --no-cache postgresql-client

WORKDIR /app

COPY --from=build /app/node_modules ./node_modules

COPY --from=build /app ./

EXPOSE 3000

CMD ["npm", "start"]
