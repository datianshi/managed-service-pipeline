module rg {
    source = "./resourcegroup"
    cluster_name = var.cluster_name
    location = var.location
}

module network {
    source = "./network"
    cluster_name = var.cluster_name
    resource_group = module.rg.name
    location = var.location
    tags = var.tags
}

module iam {
    source = "./iam"
    cluster_name = var.cluster_name
    network_id = module.network.network_id
}

# module cluster {
#     source = "./cluster"
#     cluster_name = var.cluster_name
#     location = var.location
#     pull_secret = var.pull_secret
#     tags = var.tags
#     client_id = module.iam.client_id
#     client_secret = module.iam.client_secret
#     resource_group = module.rg.name
#     control_plane_subnet = module.network.control_plane_subnet
#     machine_subnet = module.network.machine_subnet
# }

