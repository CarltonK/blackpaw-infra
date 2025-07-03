#!/bin/bash

set -euo pipefail

# Configuration
ODOO_DB="DATABASE_NAME"
BACKUP_DIR="/var/backups/odoo"
DATE=$(date +'%Y-%m-%d_%H-%M-%S')
BACKUP_FILE="$BACKUP_DIR/odoo_backup_$DATE.zip"
RCLONE_REMOTE="gdrive"  # Change if needed
GDRIVE_FOLDER="Odoo-Backups/$ODOO_DB/$DATE"

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"
chown postgres:postgres "$BACKUP_DIR"
chmod 755 "$BACKUP_DIR"

# Fix locale warnings
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

echo "📦 Starting backup for database: $ODOO_DB at $DATE"

# Step 1: Backup Odoo database (uncompressed .sql)
DUMP_PATH="$BACKUP_DIR/dump.sql"
if ! sudo -u postgres pg_dump "$ODOO_DB" > "$DUMP_PATH"; then
    echo "❌ Database backup failed!"
    exit 1
fi
echo "✅ Database dump completed: $DUMP_PATH"

# Step 2: Prepare temp structure for zipping
TEMP_DIR=$(mktemp -d)
cp "$DUMP_PATH" "$TEMP_DIR/"
mkdir -p "$TEMP_DIR/filestore"
cp -r "/var/lib/odoo/filestore/$ODOO_DB" "$TEMP_DIR/filestore/"
echo "📁 Files prepared in temp directory: $TEMP_DIR"

# Step 3: Create zip file
cd "$TEMP_DIR"
if ! zip -r "$BACKUP_FILE" dump.sql filestore/ > /dev/null; then
    echo "❌ ZIP creation failed!"
    rm -rf "$TEMP_DIR"
    exit 1
fi
echo "✅ Backup zipped: $BACKUP_FILE"

# Step 4: Cleanup local temp files
rm -rf "$TEMP_DIR"
rm -f "$DUMP_PATH"
echo "🧹 Temp files cleaned up"

# Step 5: Upload to Google Drive via rclone
if ! sudo -u blackpaw rclone copy "$BACKUP_FILE" "$RCLONE_REMOTE:$GDRIVE_FOLDER" --quiet; then
    echo "❌ Upload to Google Drive failed!"
    exit 1
fi
echo "☁️  Backup uploaded to Google Drive: $RCLONE_REMOTE:$GDRIVE_FOLDER"

echo "✅ Backup process completed successfully!"
