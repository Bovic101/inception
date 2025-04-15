FROM alpine:3.16

# Define build-time arguments for PHP version and database credentials
ARG PHP_VERSION=8 \
    DB_NAME \
    DB_USER \
    DB_PASS

# Update the package index, upgrade installed packages, and install necessary PHP packages and utilities
RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \                     # PHP core package
    php${PHP_VERSION}-fpm \                  # PHP FastCGI Process Manager
    php${PHP_VERSION}-mysqli \               # PHP MySQLi extension
    php${PHP_VERSION}-json \                 # PHP JSON extension
    php${PHP_VERSION}-curl \                 # PHP cURL extension
    php${PHP_VERSION}-dom \                  # PHP DOM extension
    php${PHP_VERSION}-exif \                 # PHP EXIF extension
    php${PHP_VERSION}-fileinfo \             # PHP FileInfo extension
    php${PHP_VERSION}-mbstring \             # PHP Mbstring extension for multibyte support
    php${PHP_VERSION}-openssl \              # PHP OpenSSL extension
    php${PHP_VERSION}-xml \                  # PHP XML extension
    php${PHP_VERSION}-zip \                  # PHP Zip extension
    php${PHP_VERSION}-redis \                # PHP Redis extension
    wget \                                   # wget for downloading files
    unzip && \                               # unzip utility for extracting files
    # Modify PHP-FPM configuration to listen on all interfaces and set correct owner/group
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    # Clean up the APK cache to reduce the image size
    rm -f /var/cache/apk/*

# Set the working directory inside the container
WORKDIR /var/www

# Download and unzip the latest WordPress package, then clean up
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \           # Move WordPress files to the current directory
    rm -rf wordpress latest.zip         # Remove unnecessary files to save space

# Copy custom WordPress configuration script to the container
COPY ./requirements/wordpress/conf/wp-config-create.sh .

# Run the WordPress config script and set appropriate permissions on wp-content directory
RUN sh wp-config-create.sh && rm wp-config-create.sh && \
    chmod -R 0777 wp-content/          # Give write permissions to wp-content

# Start PHP-FPM service in the foreground
CMD ["/usr/sbin/php-fpm${PHP_VERSION}", "-F"]
