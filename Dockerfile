FROM node:16-alpine
WORKDIR /dumbplay-fe
COPY . /dumbplay-fe
RUN npm install
EXPOSE 3000
CMD ["npm","start"]


