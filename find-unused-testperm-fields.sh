#!/bin/bash
# Find TESTPERM fields that exist in entity but NOT in detail layout
# These are the fields sitting in the right panel dock

echo "=== Finding Unused TESTPERM Fields ==="
echo ""

# Get all field names from TESTPERM.json
echo "Extracting all fields from TESTPERM entity..."
grep -o '"[^"]*": {' entityDefs/TESTPERM.json | sed 's/": {//;s/"//g' | grep -v '^fields$' | grep -v '^links$' | sort > /tmp/all_testperm_fields.txt

# Get fields used in detail layout from server
echo "Extracting fields from detail layout..."
ssh permtrak2@permtrak.com "cat /home/permtrak2/dev.permtrak.com/EspoCRM/custom/Espo/Custom/Resources/layouts/TESTPERM/detail.json" 2>/dev/null | grep -o '"name": "[^"]*"' | sed 's/"name": "//;s/"//g' | sort -u > /tmp/layout_testperm_fields.txt

# Find fields NOT in layout (these are in the dock)
echo ""
echo "=== UNUSED FIELDS (58 total) - These are in the right panel dock ==="
echo ""
comm -23 /tmp/all_testperm_fields.txt /tmp/layout_testperm_fields.txt | tee /tmp/unused_testperm_fields.txt

echo ""
echo "=== SUMMARY ==="
echo "Total fields in entity: $(wc -l < /tmp/all_testperm_fields.txt)"
echo "Fields in detail layout: $(wc -l < /tmp/layout_testperm_fields.txt)"
echo "Unused fields (in dock): $(wc -l < /tmp/unused_testperm_fields.txt)"
echo ""
echo "Unused fields list saved to: /tmp/unused_testperm_fields.txt"
echo ""
echo "NEXT STEPS:"
echo "1. Disable cache in Administration → Settings"
echo "2. Go to Layout Manager → TESTPERM → Detail"
echo "3. Remove these fields from the layout (they'll be in right panel)"
echo "4. Save and test"
echo "5. Re-enable cache"

