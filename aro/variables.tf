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
