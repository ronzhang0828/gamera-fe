# Step 1: Build Stage
FROM node:18 AS build

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the application (Assuming it's a React app or a similar frontend framework)
RUN npm run build

# Step 2: Serve the app using Nginx
FROM nginx:alpine

# Copy the build files from the build stage into the Nginx container's HTML directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
