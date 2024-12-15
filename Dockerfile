# Use Node.js as the base image
FROM node:20

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json .
RUN npm install

# Copy client and server code
COPY . .

# Build the React app
RUN npm install --prefix client && npm run build --prefix client

# Expose port and start the server
EXPOSE 5000
CMD ["npm", "run", "start"]