# Use the lightweight nginx image to serve static files
FROM nginx:alpine

# Remove default nginx static files (optional, but keeps image clean)
RUN rm -rf /usr/share/nginx/html/*

# Copy the repo contents (index.html, JS, CSS, etc.) into nginx's html folder
COPY . /usr/share/nginx/html

# Expose port 80 and run nginx in foreground
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

