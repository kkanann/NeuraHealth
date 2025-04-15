# Use the official Node.js base image
FROM node:18

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (if exists)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the code
COPY . .

# Run the app
CMD ["node", "index.js"]  # Replace with app.js or src/app.js if needed
