# Base image
FROM nginx:alpine

# Remove the default Nginx page
RUN rm -rf /usr/share/nginx/html/*

# Copy custom HTML page to container
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

