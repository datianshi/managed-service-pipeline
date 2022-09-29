variable cluster_name {
    type = string
}

variable location {
    type = string
}

variable pull_secret {
    type = string
}

variable "tags" {
  type        = map(string)
  default     = {}
}

variable "client_id" {
   type = string
}

variable "client_secret" {
   type = string
}

variable "resource_group" {
   type = string
}

variable "control_plane_subnet" {
   type = string
}

variable "machine_subnet" {
   type = string
}
