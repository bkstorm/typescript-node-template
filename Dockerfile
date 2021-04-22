FROM node:14-alpine as builder
WORKDIR /app
ADD package.json package-lock.json /app/
COPY . /app
RUN npm ci --quiet && npm run build

FROM node:14-alpine
EXPOSE 3000
WORKDIR /app
COPY package.json package-lock.json /app/
RUN npm ci --quite --only=production
COPY --from=builder /app/dist ./dist

CMD node dist/server.js