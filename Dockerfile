# Use lightweight nginx image
FROM nginx:alpine

# Remove default nginx html files
RUN rm -rf /usr/share/nginx/html/*

# Copy our HTML file to nginx's serving directory
COPY index.html /usr/share/nginx/html/

# Copy a simple script to show container ID
RUN echo '#!/bin/sh' > /usr/share/nginx/html/hostname && \
    echo 'hostname' >> /usr/share/nginx/html/hostname && \
    chmod +x /usr/share/nginx/html/hostname

# Expose port 80
EXPOSE 80

# Health check to verify nginx is running
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1