
variable cluster_name {
    type = string
}

variable machine_subnet {
    type = string
}

variable control_plane_subnet {
    type = string
}

variable pull_secret {
    type = string
}

variable tags {
    type = map(string)
}

variable resource_group {
    type = string
}

variable client_id {
    type = string
}

variable client_secret {
    type = string
}

variable location {
    type = string
}

resource "azureopenshift_redhatopenshift_cluster" "cluster" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group
  tags                = var.tags
  
  cluster_profile {
    pull_secret = var.pull_secret
  }
  master_profile {
    subnet_id = var.control_plane_subnet
  }
  worker_profile {
    subnet_id = var.machine_subnet
  }
  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

}