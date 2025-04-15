# Use Alpine Linux 3.21 as the base image
FROM alpine:3.21

# Define build arguments for PHP version and WordPress database credentials
ARG PHP_VERSION=8 \
    DB_NAME \
    DB_USER \
    DB_PASS

# Update package index, upgrade existing packages, and install required PHP extensions and tools
RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \                              # Core PHP
    php${PHP_VERSION}-fpm \                          # PHP FastCGI Process Manager
    php${PHP_VERSION}-mysqli \                       # MySQL support
    php${PHP_VERSION}-json \                         # JSON support
    php${PHP_VERSION}-curl \                         # cURL for HTTP requests
    php${PHP_VERSION}-dom \                          # DOM manipulation
    php${PHP_VERSION}-exif \                         # Image metadata
    php${PHP_VERSION}-fileinfo \                     # File type info
    php${PHP_VERSION}-mbstring \                     # Multibyte string support
    php${PHP_VERSION}-openssl \                      # OpenSSL for encryption
    php${PHP_VERSION}-xml \                          # XML parsing
    php${PHP_VERSION}-zip \                          # Zip archive handling
    wget \                                           # Download utility
    unzip &&                                         # For extracting zip files
    # Modify PHP-FPM config to listen on port 9000 and set correct permissions
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
<<<<<<< HEAD
<<<<<<< HEAD
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    # Clean up the APK cache to reduce the image size
    rm -f /var/cache/apk/*
=======
      /etc/php8/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*                           # Clean up package cache
>>>>>>> parent of 71c3133 (Configuration of the dockerfile for the wordpress and rediting of the dockerposefile)
=======
      /etc/php8/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*                           # Clean up package cache
>>>>>>> parent of 71c3133 (Configuration of the dockerfile for the wordpress and rediting of the dockerposefile)

# Set working directory for the container
WORKDIR /var/www

# Download and extract the latest WordPress package
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip                      # Remove leftovers

# Copy and execute custom script to generate wp-config.php
COPY ./requirements/wordpress/conf/wp-config-create.sh .
RUN sh wp-config-create.sh && rm wp-config-create.sh && \
    chmod -R 0777 wp-content/                        # Make wp-content fully writable (less secure, useful in dev)

<<<<<<< HEAD
<<<<<<< HEAD
# Start PHP-FPM service in the foreground
CMD ["/usr/sbin/php-fpm${PHP_VERSION}", "-F"]
=======
=======
>>>>>>> parent of 71c3133 (Configuration of the dockerfile for the wordpress and rediting of the dockerposefile)
# Start PHP-FPM in foreground mode when container runs
CMD ["/usr/sbin/php-fpm8", "-F"]
>>>>>>> parent of 71c3133 (Configuration of the dockerfile for the wordpress and rediting of the dockerposefile)
