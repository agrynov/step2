FROM node:18

WORKDIR /app


COPY package*.json ./
RUN npm ci --include=dev


COPY . .


CMD ["npm", "start"]
