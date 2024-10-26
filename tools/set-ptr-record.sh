#!/bin/sh

# UpCloud Terraform provider does not support setting PTR record for a host
# but their API does so we set it via this script.

# See https://developers.upcloud.com/1.3 and https://github.com/UpCloudLtd/terraform-provider-upcloud/issues/60

set -e

if ! [ "${2}" ]
then
  echo "Usage: $0 ip.address ptr.record"
  exit 1
fi

# Send PTR record to UpCloud API

curl -u ${UPCLOUD_USERNAME}:${UPCLOUD_PASSWORD} -X PUT -H "Content-Type: application/json" -d "{ \"ip_address\": { \"ptr_record\": \"${2}\" } }" https://api.upcloud.com/1.3/ip_address/${1}

exit 0