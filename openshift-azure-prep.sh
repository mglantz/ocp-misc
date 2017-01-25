#!/bin/bash

GROUP=$1

if [ "$GROUP" == "" ]; then
	echo "Azure group unset. Usage $0 <azure-resource-group>"
	exit 1
else
	echo "Creating resource group: $GROUP in North Europe and uploading ssh key to it."
fi

azure group create $GROUP 'North Europe'
azure keyvault create -u ${GROUP}KeyVaultName -g $GROUP -l 'North Europe'
azure keyvault secret set -u ${GROUP}KeyVaultName -s ${GROUP}SecretName --file ~/.ssh/id_rsa
azure keyvault set-policy -u ${GROUP}KeyVaultName --enabled-for-template-deployment true
