# Use the latest version of node available from docker hub
# https://hub.docker.com/_/node
FROM node:latest

# Create working directory inside the container for our app
WORKDIR /app

# Copy package(-lock) files to working directory in the container
COPY package*.json ./

# Execute npm install inside working directory to install dependencies
RUN npm install

# Bundle app source code inside the container
COPY . .

# Expose port 8080 so the application can be accessed from a web browser
EXPOSE 8080

# Start the Node.js application in the container
CMD [ "npm", "start" ]