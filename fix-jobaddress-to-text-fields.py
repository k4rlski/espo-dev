#!/usr/bin/env python3
"""
Convert jobaddress from compound address type to individual TEXT fields
This prevents EspoCRM rebuild from reverting these fields to VARCHAR.
"""

import json
import sys

def fix_jobaddress(input_file, output_file):
    """Remove compound address field, add individual TEXT fields"""
    
    print(f"Reading {input_file}...")
    with open(input_file, 'r') as f:
        data = json.load(f)
    
    if 'fields' not in data:
        print("ERROR: No 'fields' key in JSON!")
        sys.exit(1)
    
    # REMOVE the compound address field
    if 'jobaddress' in data['fields']:
        old_def = data['fields']['jobaddress']
        print(f"  ✓ Removing compound jobaddress field: {old_def}")
        del data['fields']['jobaddress']
    
    # ADD individual TEXT fields for each address component
    address_components = {
        'jobaddress_street': {'type': 'text', 'isCustom': True},
        'jobaddress_city': {'type': 'text', 'isCustom': True},
        'jobaddress_state': {'type': 'text', 'isCustom': True},
        'jobaddress_postal_code': {'type': 'text', 'isCustom': True},
    }
    
    for field_name, field_def in address_components.items():
        if field_name not in data['fields']:
            data['fields'][field_name] = field_def
            print(f"  ✓ Added {field_name} as TEXT")
        else:
            # Update existing definition to TEXT
            data['fields'][field_name]['type'] = 'text'
            print(f"  ✓ Updated {field_name} to TEXT")
    
    print(f"\nWriting to {output_file}...")
    with open(output_file, 'w') as f:
        json.dump(data, f, indent=2)
    
    print("✅ Done!")
    print(f"\nNext steps:")
    print(f"1. Review: diff {input_file} {output_file}")
    print(f"2. Deploy to sandbox and run rebuild")
    print(f"3. Verify address fields stay as TEXT!")
    print(f"\n⚠️  NOTE: This changes the UI for jobaddress from an address widget to individual text fields.")

if __name__ == '__main__':
    input_file = 'entityDefs/TESTPERM.json'
    output_file = 'entityDefs/TESTPERM.json.FIXED2'
    
    fix_jobaddress(input_file, output_file)

