#!/bin/bash
#
# PWD Optimization Revert Script
# Use this if you need to rollback the optimization changes
#
# Date: November 3, 2025
# Author: DEVOPS-KARL

set -e

BACKUP_FILE="entityDefs/PWD.json.backup-20251103_052858"
CURRENT_FILE="entityDefs/PWD.json"

echo "=========================================="
echo "  PWD Optimization REVERT Script"
echo "=========================================="
echo ""

# Check if backup exists
if [ ! -f "$BACKUP_FILE" ]; then
    echo "❌ ERROR: Backup file not found: $BACKUP_FILE"
    exit 1
fi

# Show what will be reverted
echo "This will revert PWD.json to the pre-optimization state."
echo ""
echo "Current file:  $CURRENT_FILE (24K - optimized)"
echo "Backup file:   $BACKUP_FILE (23K - original)"
echo ""

# Confirmation
read -p "Are you sure you want to REVERT the optimization? [y/N]: " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Revert cancelled."
    exit 0
fi

# Create safety backup of optimized version
echo ""
echo "📦 Creating safety backup of optimized version..."
cp "$CURRENT_FILE" "${CURRENT_FILE}.before-revert-$(date +%Y%m%d_%H%M%S)"

# Revert to backup
echo "⏪ Reverting to pre-optimization state..."
cp "$BACKUP_FILE" "$CURRENT_FILE"

echo ""
echo "✅ Revert complete!"
echo ""
echo "Next steps:"
echo "1. Deploy to server (if already deployed):"
echo "   scp '$CURRENT_FILE' permtrak2@permtrak.com:/home/permtrak2/dev.permtrak.com/EspoCRM/custom/Espo/Custom/Resources/metadata/entityDefs/"
echo ""
echo "2. Rebuild on server:"
echo "   ssh permtrak2@permtrak.com"
echo "   cd /home/permtrak2/dev.permtrak.com/EspoCRM"
echo "   php command.php clear-cache"
echo "   php command.php rebuild"
echo ""
echo "Or use Git:"
echo "   git add entityDefs/PWD.json"
echo "   git commit -m 'Reverted PWD optimization'"
echo "   git push origin main"
echo ""

