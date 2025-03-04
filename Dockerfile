FROM node:18

WORKDIR /app

COPY package*.json ./
# Сначала создаем package-lock.json, если его нет
RUN npm install --include=dev
# Затем копируем все файлы
COPY . .

CMD ["npm", "start"]
