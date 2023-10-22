# Stage 1: Build the Vue.js frontend

# Use a lightweight Node.js image with Alpine Linux
FROM node:18.18-alpine as vue-build

# Set the working directory to /app
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the entire project to the working directory
COPY . .

# Build the Vue.js application
RUN npm run build


# Stage 2: Set up NGINX and copy custom nginx.conf

# Use a lightweight NGINX image with Alpine Linux as the production build
FROM nginx:1.25.2-alpine as production-build

# Set the working directory to /app/dist
WORKDIR /app/dist

# Overwrite the default NGINX configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the built Vue.js application from the frontend build stage
COPY --from=vue-build /app/dist .

# Expose port 80 to allow external connections
EXPOSE 80

# Specify the command to run NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
