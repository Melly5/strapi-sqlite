FROM node:20-alpine

# Устанавливаем системные зависимости для сборки (лучше добавить libc6-compat для node-gyp)
RUN apk add --no-cache python3 make g++ libc6-compat

WORKDIR /opt/app

COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile

COPY . .

RUN yarn build

EXPOSE 1337

CMD ["yarn", "develop"]
