// parameters and variables for the resources
@description('Location for all resources.')
param location string = resourceGroup().location

@description('Tags for the resources')
param tags object = {
  owner: 'Steve'
  environment: 'test'
}

@minLength(3)
@maxLength(24)
@description('Name of the storage account')
param storageAccountName string = 'storageoelietech6'
@allowed([
  'westeurope'
  'northeurope'
  'Standard_LRS'
  'Standard_GRS'
])

@description('SKU for the storage account')
param storageAccountSku string = 'Standard_LRS'

@description('Support HTTPS traffic only')
param supportsHttpsTrafficOnly bool = true

var storageAccountKind = 'StorageV2'

var storageAccountPropeties = {
  accessTier: 'Cool'
  minimumTlsVersion: 'TLS1_2'
  supportsHttpsTrafficOnly: supportsHttpsTrafficOnly
}

// Configuration for the storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  tags: tags
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: storageAccountKind
  properties: storageAccountPropeties
  }

// output for the storage account
  output storageAccountName string = storageAccount.name
  output storageAccountId string = storageAccount.id
