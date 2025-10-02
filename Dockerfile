<<<<<<< HEAD
FROM node:20-alpine
=======
FROM node:20-alpine AS build
>>>>>>> 43c60fd03758c69e1c5174ed1ee0ec29740d63e6

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
