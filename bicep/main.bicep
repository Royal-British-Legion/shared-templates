targetScope = 'subscription'
@description('')
param location string = 'uksouth'
@description('Storage Account type')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_ZRS'
  'Premium_LRS'
])
param skuName string = 'Standard_LRS'
@description('Resource group for Terraform state resources')
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'shared-state-rg'
  location: location
  tags: {
    owner: 'terraform'
  }
}
module storage 'modules/storage.bicep' = {
  scope: rg
  name: 'shared-state-rg'
  params: {
    skuName: skuName
    location: location
  }
}
