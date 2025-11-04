#!/usr/bin/env python3
"""
Fix TESTPERM.json - Update field types to TEXT
This makes JSON metadata match the actual database TEXT conversions.
Without this, rebuild.php will revert TEXT fields back to VARCHAR!
"""

import json
import sys

# List of 61 fields that should be TEXT (from SQL conversion scripts)
TEXT_FIELDS = [
    'adnumbernews', 'attyassistant', 'attyname', 'attyfirm',
    'autoprintewp', 'autoprintjsbp', 'autoprintonline', 'autoprintswa',
    'coaddress', 'cocity', 'cocounty', 'coemailcontactstandard',
    'coemailpermads', 'coemailpermadsloginurl', 'coemailpermadspass',
    'cofein', 'conaics', 'contactemail', 'contactname',
    'dboxemailthreadcase', 'dboxemailthreadnews', 'dboxemailthreadswa',
    'dboxewpend', 'dboxewpstart', 'dboxjsbpend', 'dboxjsbpstart',
    'dboxlocalts', 'dboxnewsts1', 'dboxnewsts2', 'dboxonlineend', 'dboxonlinestart',
    'dboxradioinvoice', 'dboxradioscript', 'dboxswaend', 'dboxswastart',
    'dolbkupcodes', 'domainname',
    'jobaddress_city', 'jobaddress_country', 'jobaddress_postal_code', 
    'jobaddress_state', 'jobaddress_street',
    'jobeducation', 'jobexperience', 'jobhours', 'jobnaics',
    'jobsiteaddress', 'jobsitecity', 'jobsitezip', 'jobtitle',
    'parentid',
    'statswaemail', 'stripeinvoiceid', 'stripepaymentlink',
    'swacomment', 'swasubacctpass',
    'trxstring',
    'urlgmailadconfirm', 'urljsbp', 'urlonline', 'urlqbpaylink',
    'urlswa', 'urltrxmercury', 'urlweb',
    'yournamefirst', 'yournamelast'
]

def fix_testperm_json(input_file, output_file):
    """Read TESTPERM.json, update TEXT field types, write back"""
    
    print(f"Reading {input_file}...")
    with open(input_file, 'r') as f:
        data = json.load(f)
    
    if 'fields' not in data:
        print("ERROR: No 'fields' key in JSON!")
        sys.exit(1)
    
    updated_count = 0
    missing_fields = []
    
    for field_name in TEXT_FIELDS:
        if field_name in data['fields']:
            # Update to TEXT type
            old_type = data['fields'][field_name].get('type', 'unknown')
            data['fields'][field_name]['type'] = 'text'
            
            # Remove maxLength (not needed for TEXT)
            if 'maxLength' in data['fields'][field_name]:
                del data['fields'][field_name]['maxLength']
            
            # Remove dbType and len (not needed for TEXT)
            if 'dbType' in data['fields'][field_name]:
                del data['fields'][field_name]['dbType']
            if 'len' in data['fields'][field_name]:
                del data['fields'][field_name]['len']
            
            updated_count += 1
            print(f"  ✓ {field_name}: {old_type} → text")
        else:
            missing_fields.append(field_name)
    
    print(f"\n✅ Updated {updated_count} fields to TEXT")
    
    if missing_fields:
        print(f"\n⚠️  {len(missing_fields)} fields not found in JSON:")
        for field in missing_fields:
            print(f"    - {field}")
    
    print(f"\nWriting to {output_file}...")
    with open(output_file, 'w') as f:
        json.dump(data, f, indent=2)
    
    print("✅ Done!")
    print(f"\nNext steps:")
    print(f"1. Review the changes: diff {input_file} {output_file}")
    print(f"2. Copy to sandbox and dev")
    print(f"3. Run rebuild.php - TEXT fields should now STAY as TEXT!")

if __name__ == '__main__':
    input_file = 'entityDefs/TESTPERM.json'
    output_file = 'entityDefs/TESTPERM.json.FIXED'
    
    fix_testperm_json(input_file, output_file)

