FROM node:16-alpine as build
WORKDIR /dumbplay-fe
COPY . /dumbplay-fe

FROM build
COPY --from=build /dumbplay-fe /dumbplay-fe
WORKDIR /dumbplay-fe
RUN npm install
EXPOSE 3000
CMD ["npm","start"]


