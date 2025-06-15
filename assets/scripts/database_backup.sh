#!/bin/bash

# Configuration
ODOO_DB="DATABASE_NAME_HERE"
BACKUP_DIR="/var/backups/odoo"
DATE=$(date +'%Y-%m-%d_%H-%M-%S')
BACKUP_FILE="$BACKUP_DIR/odoo_backup_$DATE.zip"
RCLONE_REMOTE="gdrive"  # Change if you named your remote differently

# Ensure backup directory exists
mkdir -p $BACKUP_DIR
chown postgres:postgres $BACKUP_DIR
chmod 755 $BACKUP_DIR

# Fix locale warnings
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

# Backup Odoo database
sudo -u postgres bash -c "pg_dump $ODOO_DB | gzip > '$BACKUP_DIR/$ODOO_DB-$DATE.sql.gz'"
if [[ $? -ne 0 ]]; then
    echo "❌ Database backup failed!"
    exit 1
fi
echo "✅ Pg dump completed successfully!"

# Backup Odoo filestore
zip -r "$BACKUP_FILE" /var/lib/odoo $BACKUP_DIR/$ODOO_DB-$DATE.sql.gz
if [[ $? -ne 0 ]]; then
    echo "❌ ZIP creation failed!"
    exit 1
fi
echo "✅ Zipping completed successfully!"

# Upload backup to Google Drive
sudo -u blackpaw rclone copy $BACKUP_FILE "$RCLONE_REMOTE:/Odoo-Backups/$ODOO_DB/$DATE"
if [[ $? -ne 0 ]]; then
    echo "❌ Upload to Google Drive failed!"
    exit 1
fi

echo "✅ Backup completed successfully and uploaded to Google Drive!"