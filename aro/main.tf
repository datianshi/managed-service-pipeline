module rg {
    source = "./resourcegroup"
    cluster_name = var.cluster_name
}

module network {
    source = "./network"
    cluster_name = var.cluster_name
    tags = var.tags
}

module iam {
    source = "./iam"
    cluster_name = var.cluster_name
}

module cluster {
    source = "./cluster"
    cluster_name = var.cluster_name
    location = var.location
    pull_secret = var.pull_secret
    tags = var.tags
    client_id = module.iam.client_id
    client_secret = module.iam.client_secret
    resource_group = module.rg.id
    control_plane_subnet = module.network.control_plane_subnet
    control_plane_subnet = module.network.machine_subnet
}

