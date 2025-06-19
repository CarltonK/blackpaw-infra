# 🧾 Odoo Community Edition Server Setup

This guide outlines the steps and requirements for setting up an Odoo Community Edition instance on a production-grade server. This setup assumes a clean Debian 11 installation and includes secure user setup, SSH access, and Odoo installation via an automated script.

---

## ✅ Requirements

- **OS:** Debian 11 (Bullseye)
- **User setup:** Secure, non-root sudo user
- **Access:** SSH keys (no password login)
- **Odoo setup:** Automated via `odoo_setup.sh` script (included in this repository at assets/scripts)

---

## 🛠️ 1. Initial Server Setup
Follow the DigitalOcean guide below to create a **non-root user** with `sudo` privileges and configure a basic firewall:

📄 [Initial Server Setup with Ubuntu (applies to Debian)](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu)

> ⚠️ Replace `ubuntu` with `debian` where applicable.


If ufw is not installed, then install with
```bash
apt install ufw
```

---

## 🔐 2. SSH Key Authentication
Set up secure SSH key access using this guide:

📄 [How To Set Up SSH Keys on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04)

> ⚠️ This disables password-based login and increases server security.

---

## 🐍 3. Odoo Installation
This repository includes a setup script to fully automate the Odoo 17 Community Edition installation process.

### 📁 Script Location:
```bash
chmod +x ./assets/scripts/odoo_setup.sh
./assets/scripts/odoo_setup.sh
```

## 🌍 4. Accessing Odoo
Once installation completes and the Odoo service is running, access it from your browser:

```
http://SERVER_IP_HERE:8069
```

## 📦 5. Installing Community Modules
To install additional community modules (addons):

🧰 Step-by-Step:
1. Download the module to your local PC

2. Copy the module to the VM
```bash
scp Downloads/CUSTOM_MODULE blackpaw@VM_IP_HERE:/home/blackpaw
```

3. Unzip the module into the custom Odoo addons folder (/opt/odoo/addons)
```bash
apt install unzip # If unzip is not installed
unzip CUSTOM_MODULE -d /opt/odoo/addons
```

4. Restart Odoo
```bash
sudo systemctl restart odoo
```

5. Update the App List
    1. Login to the Odoo web interface
    2. Go to Apps
    3. Click Update App List in the debug/developer mode
    4. Search and install your new modules