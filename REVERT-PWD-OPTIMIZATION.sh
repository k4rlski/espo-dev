#!/bin/bash
# Emergency Revert Script for PWD.json Optimization
# Created: November 3, 2025
# Use this script if the PWD optimization causes issues

set -e

BACKUP_FILE="entityDefs/PWD.json.backup-20251103_052858"
TARGET_FILE="entityDefs/PWD.json"
BACKUP_CHECKSUM="7522ad6a59796afedfd8fb9ec5248259"

echo "======================================================================="
echo "  PWD.json OPTIMIZATION REVERT SCRIPT"
echo "======================================================================="
echo ""
echo "⚠️  This will revert PWD.json to the pre-optimization version"
echo ""

# Verify backup exists
if [ ! -f "$BACKUP_FILE" ]; then
    echo "❌ ERROR: Backup file not found: $BACKUP_FILE"
    exit 1
fi

# Verify backup checksum
CURRENT_BACKUP_CHECKSUM=$(md5sum "$BACKUP_FILE" | awk '{print $1}')
if [ "$CURRENT_BACKUP_CHECKSUM" != "$BACKUP_CHECKSUM" ]; then
    echo "⚠️  WARNING: Backup file checksum doesn't match!"
    echo "   Expected: $BACKUP_CHECKSUM"
    echo "   Got:      $CURRENT_BACKUP_CHECKSUM"
    read -p "Continue anyway? [y/N]: " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Create a backup of the current (optimized) version
REVERT_BACKUP="entityDefs/PWD.json.optimized-$(date +%Y%m%d_%H%M%S)"
echo "📦 Creating backup of current version: $REVERT_BACKUP"
cp "$TARGET_FILE" "$REVERT_BACKUP"

# Revert to pre-optimization version
echo "↩️  Reverting to pre-optimization version..."
cp "$BACKUP_FILE" "$TARGET_FILE"

echo ""
echo "✅ PWD.json has been reverted to pre-optimization version"
echo ""
echo "Next steps:"
echo "1. If on server, run:"
echo "   cd /home/permtrak2/dev.permtrak.com/EspoCRM"
echo "   php command.php clear-cache"
echo "   php command.php rebuild"
echo ""
echo "2. If using Git, commit the revert:"
echo "   git add entityDefs/PWD.json"
echo "   git commit -m 'Revert: PWD optimization caused issues'"
echo "   git push origin main"
echo ""
echo "3. Your optimized version was saved to: $REVERT_BACKUP"
echo "======================================================================="
