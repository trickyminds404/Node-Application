FROM node:18

WORKDIR /app

COPY src/package*.json ./

RUN npm install

COPY src/ .

EXPOSE 3000

CMD ["node", "index.js"]]
