
variable cluster_name {
    type = string
}

variable location {
    type = string
}

resource "azurerm_resource_group" "this" {
    name        = "${var.cluster_name}-rg"
    location    = var.location
}

output name {
    value = "${var.cluster_name}-rg"
}