# Stage 1: Build
FROM node:18 AS build
WORKDIR /usr/src/app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build

# Stage 2: Production
FROM node:18-alpine3.16 AS production
WORKDIR /usr/src/app
RUN yarn global add serve
COPY --from=build /usr/src/app/dist /usr/src/app/dist
EXPOSE 3000
CMD ["serve", "-s", "dist", "-l", "3000"]
