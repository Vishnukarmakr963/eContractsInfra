@description('Resource Group Location')
param location string = 'East US'

@description('App Service Plan Name')
param appServicePlanName string = 'clmAppServicePlan' //Name of the app service plan

@description('Web App Name')
param webAppName string = 'clm-webapp' //Name of the web app

@description('Storage Account Name')
param storageAccountName string = 'clmstorageacct' //Name of the storage account

@description('SKU for App Service Plan')
param appServiceSku string = 'S1'  // App Service plan. Change based on requirements

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
