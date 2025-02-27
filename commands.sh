# Azure CLI

# Create a resource group
az group create  --location westeurope --name RG-Bicep

# What-if we want to deploy a Bicep template?
az deployment group what-if --subscription a63c6cb5-b6bb-4c4f-8061-74ff335b58b2 --resource-group RG-Bicep --template-file main.bicep

# Deploy Bicep template
az deployment group create --subscription a63c6cb5-b6bb-4c4f-8061-74ff335b58b2 --resource-group RG-Bicep --template-file main.bicep
