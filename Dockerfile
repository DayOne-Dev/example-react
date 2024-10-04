# https://hub.docker.com/_/node
FROM psazuse.jfrog.io/krishnam-docker-virtual/node:20-alpine
# RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /app
USER node
# RUN chmod -R 755 * 
# RUN npm config set cache temp

# Copy package.json and package-lock.json to the container
COPY package*.json ./
# Copy the rest of the application code to the container
COPY --chown=node:node . .

RUN npm ls
RUN npm cache clean --force
# RUN pwd && ls -lrta 

# Install dependencies
RUN npm install

EXPOSE 3000
# CMD [ "npm", "start"]
CMD [ "npm", "index.js"]