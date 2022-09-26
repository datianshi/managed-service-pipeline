variable cluster_name {
    type = string
}

resource "azurerm_resource_group" "this" {
    name        = "${var.cluster_name}-rg"
    location    = var.location
}

output id {
    value = azurerm_resource_group.this.id
}