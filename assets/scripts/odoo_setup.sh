#!/bin/bash

# Update system packages
sudo apt update
sudo apt upgrade -y

# Install dependencies
sudo apt install -y git python3-pip build-essential python3-dev python3-wheel libxslt-dev libzip-dev libldap2-dev libsasl2-dev python3-setuptools python3-psycopg2 nodejs npm

# Install PostgreSQL
sudo apt install -y postgresql
