variable cluster_name {
    type = string
}

variable "aro_virtual_network_cidr_block" {
  type        = string
  default     = "10.0.0.0/22"
  description = "cidr range for aro virtual network"
}

variable "aro_control_subnet_cidr_block" {
  type        = string
  default     = "10.0.0.0/23"
  description = "cidr range for aro control plane subnet"
}

variable "aro_machine_subnet_cidr_block" {
  type        = string
  default     = "10.0.2.0/23"
  description = "cidr range for aro machine subnet"
}

variable "tags" {
  type        = map(string)
  default     = {}
}

resource "azurerm_virtual_network" "this" {
    name                = "${var.cluster_name}-vnet"
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name
    address_space       = [var.aro_virtual_network_cidr_block]
    tags                = var.tags
}

resource "azurerm_subnet" "control_plane_subnet" {
  name                    = "${var.cluster_name}-cp-subnet"
  resource_group_name     = azurerm_resource_group.main.name
  virtual_network_name    = azurerm_virtual_network.main.name
  address_prefixes        = [var.aro_control_subnet_cidr_block]
  service_endpoints       = ["Microsoft.Storage", "Microsoft.ContainerRegistry"]
  enforce_private_link_service_network_policies = true
  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_subnet" "machine_subnet" {
  name                  = "${var.cluster_name}-machine-subnet"
  resource_group_name   = azurerm_resource_group.main.name
  virtual_network_name  = azurerm_virtual_network.main.name
  address_prefixes      = [var.aro_machine_subnet_cidr_block]
  service_endpoints     = ["Microsoft.Storage", "Microsoft.ContainerRegistry"]
}

output control_plane_subnet {
    value = azurerm_subnet.control_plane_subnet.id
}

output machine_subnet {
    value = azurerm_subnet.machine_subnet.id
}