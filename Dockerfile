# Use the official PHP image with Apache
FROM php:7.4-apache

# Copy application files to the container
COPY . /var/www/html/

# Expose port 80 for the web server
EXPOSE 80
