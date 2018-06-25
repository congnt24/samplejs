FROM mhart/alpine-node:8.9.4


WORKDIR /app
ADD . /app
RUN npm install
EXPOSE 3000
CMD ["npm", "start"]