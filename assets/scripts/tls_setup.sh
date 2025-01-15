#!/bin/bash

# Define the domain name
DOMAIN_NAME="yourdomain.com"

# Update package lists and install Nginx
echo "Updating package lists..."
sudo apt update

echo "Installing Nginx..."
yes | sudo apt install nginx

# Start and enable Nginx to start at boot
echo "Starting and enabling Nginx..."
sudo systemctl start nginx
sudo systemctl enable nginx

# Install Certbot and the Nginx plugin for SSL
echo "Installing Certbot and Nginx plugin..."
yes | sudo apt install certbot python3-certbot-nginx

# Create the Nginx configuration for the domain
echo "Creating Nginx configuration for $DOMAIN_NAME..."
sudo tee /etc/nginx/sites-available/$DOMAIN_NAME > /dev/null <<EOL
server {
    server_name $DOMAIN_NAME;

    proxy_read_timeout 720s;
    proxy_connect_timeout 720s;
    proxy_send_timeout 720s;

    # Increase the maximum upload file size
    client_max_body_size 200m;

    # Proxy settings
    proxy_buffer_size 128k;
    proxy_buffers 4 256k;
    proxy_busy_buffers_size 256k;

    # Log files for debugging
    access_log /var/log/nginx/odoo-access.log;
    error_log /var/log/nginx/odoo-error.log;

    # Main location block
    location / {
        proxy_pass http://127.0.0.1:8069;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }

    # Allow Let's Encrypt ACME challenge requests
    location ~ /.well-known/acme-challenge {
        allow all;
    }

    # SSL settings managed by Certbot (uncomment after Certbot runs)
    # listen 443 ssl; # managed by Certbot
    # ssl_certificate /etc/letsencrypt/live/$DOMAIN_NAME/fullchain.pem; # managed by Certbot
    # ssl_certificate_key /etc/letsencrypt/live/$DOMAIN_NAME/privkey.pem; # managed by Certbot
    # include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    # ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}
EOL

# Enable the configuration and reload Nginx
echo "Enabling the Nginx configuration..."
sudo ln -s /etc/nginx/sites-available/$DOMAIN_NAME /etc/nginx/sites-enabled/

echo "Testing Nginx configuration..."
sudo nginx -t

echo "Reloading Nginx..."
sudo systemctl reload nginx

# Allow Nginx traffic through the firewall
echo "Updating firewall rules..."
sudo ufw allow 'Nginx Full'
sudo ufw reload

# Obtain an SSL certificate using Certbot
echo "Obtaining SSL certificate for $DOMAIN_NAME..."
sudo certbot --nginx -d $DOMAIN_NAME

# Test Certbot auto-renewal
echo "Testing Certbot auto-renewal..."
sudo certbot renew --dry-run

# Reload Nginx
echo "Reloading Nginx after SSL configuration..."
sudo systemctl reload nginx

echo "Setup complete! Your server is now configured with TLS encryption for $DOMAIN_NAME."
