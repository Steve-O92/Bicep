
targetScope = 'subscription'


resource resourcegroup 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: 'RG-Bicep'
  location: 'westeurope'
}
