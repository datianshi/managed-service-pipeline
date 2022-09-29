# module rg {
#     source = "./resourcegroup"
#     cluster_name = var.cluster_name
#     location = var.location
# }

# module network {
#     source = "./network"
#     cluster_name = var.cluster_name
#     resource_group = module.rg.name
#     location = var.location
#     tags = var.tags
# }

# module iam {
#     source = "./iam"
#     cluster_name = var.cluster_name
#     network_id = module.network.network_id
# }

module cluster {
    source = "./cluster"
    cluster_name = var.cluster_name
    location = var.location
    pull_secret = var.pull_secret
    tags = var.tags
    client_id = var.client_id
    client_secret = var.client_secret
    resource_group = var.resource_group
    control_plane_subnet = var.control_plane_subnet
    machine_subnet = var.machine_subnet
}

