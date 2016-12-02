#!/bin/sh

set -e

echo "Setting up Apache environment"

# Disable default site
a2dissite 000-default
# Enable custom site
a2ensite site
# Enable required modules
a2enmod headers rewrite proxy proxy_http socache_shmcb ssl
