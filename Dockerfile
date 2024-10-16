# https://hub.docker.com/_/node
FROM psazuse.jfrog.io/krishnam-docker-virtual/node:18-alpine
# RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /app

# RUN chmod -R 755 * 
# RUN npm config set cache temp

# Copy package.json and package-lock.json to the container
COPY package*.json ./
RUN npm install

# Install dependencies
RUN npm install

COPY . .

EXPOSE 3000
CMD [ "npm", "index.js"]