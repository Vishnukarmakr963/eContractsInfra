@description('Resource Group Location')
param location string = 'East US'

@description('App Service Plan Name')
param appServicePlanName string = 'clmAppServicePlan'

@description('Web App Name')
param webAppName string = 'clm-webapp'

@description('Storage Account Name')
param storageAccountName string = 'clmstorageacct'

@description('SKU for App Service Plan')
param appServiceSku string = 'S1'  // Change based on requirements

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServiceSku
    tier: 'Standard'
  }
  kind: 'app'
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

output webAppUrl string = webApp.properties.defaultHostName
output storageAccountId string = storageAccount.id
