@description('Storage redundancy (recommended to use at least ZRS)')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_ZRS'
  'Premium_LRS'
])
param skuName string = 'Standard_LRS'
@description('')
param location string = 'uksouth'
@description('')

resource account 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: 'rblsharedtfstatestorage'
  location: location
  sku: {
    name: skuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowSharedKeyAccess: true
    supportsHttpsTrafficOnly: true
  }

  resource bs 'blobServices' = {
    name: 'default'

    resource container 'containers' = {
      name: 'tfstate'
    }
  }
}

output account string = account.name
output container string = account::bs::container.name
