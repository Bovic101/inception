#!/bin/sh 

# Check if the WordPress config file does not already exist
if [ ! -f "/var/www/wp-config.php" ]; then

  # If it doesn't exist, create the wp-config.php file with the necessary configuration
  cat << EOF > /var/www/wp-config.php
<?php
// Set database name using environment variable
define( 'DB_NAME', '${DB_NAME}' );

// Set database user using environment variable
define( 'DB_USER', '${DB_USER}' );

// Set database password using environment variable
define( 'DB_PASSWORD', '${DB_PASS}' );

// Set the database host to 'mariadb' (likely a Docker service name)
define( 'DB_HOST', 'mariadb' );

// Set database character set
define( 'DB_CHARSET', 'utf8' );

// Set database collation (left empty)
define( 'DB_COLLATE', '' );

// Use direct file system method for updates (useful for containerized setups)
define('FS_METHOD','direct');

// Set the table prefix for the WordPress database
\$table_prefix = 'wp_';

// Disable WordPress debug mode
define( 'WP_DEBUG', false );

// Define the absolute path to the WordPress directory
if ( ! defined( 'ABSPATH' ) ) {
define( 'ABSPATH', __DIR__ . '/' );}

// Load WordPress settings
require_once ABSPATH . 'wp-settings.php';
EOF

fi  # End of if statement
