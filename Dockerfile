FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install --production

COPY . .

FROM node:20-alpine AS production

WORKDIR /app

COPY --from=build /app/node_modules ./node_modules

COPY --from=build /app ./

EXPOSE 3000

CMD ["npm", "start"]
