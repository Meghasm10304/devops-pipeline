# Use official Node.js image
FROM node:20

# Set working directory
WORKDIR /app

# Copy package.json & install dependencies
COPY package*.json ./
RUN npm install

# Copy app code
COPY . .

# Expose port
EXPOSE 3000

# Start the app
CMD ["node", "app.js"]
