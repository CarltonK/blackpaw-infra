#!/bin/bash

# Update system packages
sudo apt update
sudo apt upgrade -y

# Install dependencies
sudo apt install -y git python3-pip build-essential python3-dev python3-wheel libxslt-dev libzip-dev libldap2-dev libsasl2-dev python3-setuptools python3-psycopg2 nodejs npm software-properties-common

# Add Python3.10
yes | sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.10 python3-pip

# Install PostgreSQL
sudo apt install -y postgresql

# Create odoo user and group
sudo groupadd -r odoo
sudo useradd -r -g odoo odoo

# Set the password for the 'postgres' user to 'odoo'
echo "postgres:odoo" | sudo chpasswd

# Switch to postgres user to execute PostgreSQL commands
sudo -u postgres psql -c "CREATE USER odoo WITH PASSWORD 'odoo'; ALTER USER odoo WITH CREATEDB;"

# Install Wkhtmltopdf
sudo apt install -y wkhtmltopdf

# Clone Odoo repository
sudo git clone https://www.github.com/odoo/odoo --depth 1 --branch 17.0 /opt/odoo

# Install Python dependencies
sudo pip3 install -r /opt/odoo/requirements.txt

# Create Odoo configuration file
sudo cp /opt/odoo/debian/odoo.conf /etc/odoo.conf
sudo sed -i 's/db_user = .*/db_user = odoo/' /etc/odoo.conf
sudo sed -i 's/db_password = .*/db_password = odoo/' /etc/odoo.conf

# Create directory for Odoo sessions
sudo mkdir -p /var/lib/odoo/sessions
sudo chown -R odoo:odoo /var/lib/odoo

# Create systemd service file
sudo tee /etc/systemd/system/odoo.service > /dev/null <<EOF
[Unit]
Description=Odoo
Requires=postgresql.service
After=network.target postgresql.service

[Service]
Type=simple
SyslogIdentifier=odoo
PermissionsStartOnly=true
User=odoo
Group=odoo
ExecStart=/opt/odoo/odoo-bin -c /etc/odoo.conf
StandardOutput=journal+console

[Install]
WantedBy=multi-user.target
EOF

# Start Odoo service and enable autostart
sudo systemctl daemon-reload
sudo systemctl start odoo
sudo systemctl enable odoo

# Adjust firewall settings
# sudo ufw allow 8069

echo "Odoo has been successfully installed and configured."
echo "You can access Odoo by navigating to http://your_server_ip:8069 in a web browser."