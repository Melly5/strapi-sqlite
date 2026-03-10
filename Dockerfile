# 1. Используем официальный образ Node.js
FROM node:18-slim

# 2. Устанавливаем системные зависимости для Strapi и SQLite CLI (для Velero)
# RUN apt-get update && apt-get install -y \
#    build-essential \
#    gcc \
#    make \
#    python3 \
#    libvips-dev \
#    sqlite3 \
#    && rm -rf /var/lib/apt/lists/*

# 3. Указываем рабочую директорию
WORKDIR /opt/app

# 4. Копируем файлы зависимостей
COPY package.json package-lock.json ./

# 5. Устанавливаем зависимости Node.js
RUN npm install

# 6. Копируем весь проект
COPY . .

# 7. Собираем админку Strapi
RUN npm run build

# 8. Открываем порт 1337
EXPOSE 1337

# 9. Запускаем Strapi
CMD ["npm", "run", "develop"]
