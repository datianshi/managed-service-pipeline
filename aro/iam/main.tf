variable cluster_name {
    type = string
}

data "azurerm_subscription" "current" {}

data "azuread_client_config" "current" {}

# Needed so we can assign it the 'Network Contributor' role on the created VNet
data "azuread_service_principal" "aro_resource_provisioner" {
    display_name            = "Azure Red Hat OpenShift RP"
}

resource "azuread_application" "cluster" {
    display_name            = "${var.cluster_name}-cluster-app"
    owners                  = [data.azuread_client_config.current.object_id]
}

resource "azuread_application_password" "cluster" {
    application_object_id   = azuread_application.cluster.object_id
}

resource "azuread_service_principal" "cluster" {
    application_id  = azuread_application.cluster.application_id
    owners          = [data.azuread_client_config.current.object_id]
}

resource "azurerm_role_assignment" "main" {
        scope                   = data.azurerm_subscription.current.id
        role_definition_name    = "Contributor"
        principal_id            = azuread_service_principal.cluster.object_id
}

resource "azurerm_role_assignment" "vnet" {
    scope                   = data.azurerm_virtual_network.network.id
    role_definition_name    = "Network Contributor"
    principal_id            = data.azuread_service_principal.aro_resource_provisioner.object_id
}

output client_id {
    value = azuread_application.cluster.application_id
}

output client_secret {
    value = azuread_application_password.cluster.value
}