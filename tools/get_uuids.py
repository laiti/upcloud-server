# simple script to get list of disk UUIDs and Zones

import upcloud_api, os
from upcloud_api import Server, Storage, login_user_block

manager = upcloud_api.CloudManager(os.environ['UPCLOUD_USERNAME'], os.environ['UPCLOUD_PASSWORD'])
manager.authenticate()

templates = manager.get_templates()
zones = manager.get_zones()

print("Templates:")
print(templates)

print("\nZones:")
print(zones)