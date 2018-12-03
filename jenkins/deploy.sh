#!/bin/bash

VAGRANT_CLOUD_API=https://app.vagrantup.com/api/v1
VAGRANT_CLOUD_USER=codeyourinfra
VAGRANT_CLOUD_BOX=jenkins

BOX_VERSION=$(date '+%Y%m%d.0.0')
BOX_VERSIONS_ENDPOINT=$VAGRANT_CLOUD_API/box/$VAGRANT_CLOUD_USER/$VAGRANT_CLOUD_BOX/versions
BOX_VERSION_ENDPOINT=$VAGRANT_CLOUD_API/box/$VAGRANT_CLOUD_USER/$VAGRANT_CLOUD_BOX/version/$BOX_VERSION

STATUS_CODE=$(curl -H "Authorization: Bearer $VAGRANT_CLOUD_TOKEN" $BOX_VERSION_ENDPOINT -I 2>/dev/null | head -n 1 | cut -d$' ' -f2)
if [ $STATUS_CODE -eq 200 ]; then
    echo "Version already deployed"
    exit 1
fi

curl -H "Authorization: Bearer $VAGRANT_CLOUD_TOKEN" -H "Content-Type: application/json" -d '{"version": {"version": "'"$BOX_VERSION"'", "description": "A new version"}}' $BOX_VERSIONS_ENDPOINT
echo "Version $BOX_VERSION created"
exit 0