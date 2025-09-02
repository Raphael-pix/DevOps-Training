# Step 1: Use an offical Node Js image as the build environment
FROM node:18-alpine AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy rest of the code
COPY . .

# Build Application
RUN npm run build

# Step 2: Use an Nginx image to serve the built files
FROM nginx:alpine

# Copy build output to Nginx HTML folder
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD [ "nginx", "-g", "daemon off;"  ]