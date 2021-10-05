variable "compartment_name" {
    type = string
    description = "Name of existing compartment we want to use"
}

variable "compartment_state" {
    type = string  
    default = "ACTIVE"
    description = "State of existing compartment we want to use"
}

variable "vcn_name" {
    type = string
    description = "VCN name"
}

variable "vcn_dns_label" {
    type = string
    description = "VCN dns label"
}

variable "vcn_cidrs" {
    type = list(string)
    description = "List of VCN CIDRs"
    default = [ "172.19.0.0/16" ]
}

variable "freeform_tags" {
    type = map(string)
    description = "Free from tags"
}

variable "label_prefix" {
    type = string
    description = "A string to be prepended to the name of resources"
}

variable "internet_gateway_display_name" {
    type = string
    description = "Internet Gateway display name"
}

variable "security_list_name" {
    type = string
    description = "Subnet security list name"
}


variable k8s_subnet_cidr {
    type = string
    description = "Kubernetes Cluster subnet CIDR"
    default = "172.19.0.0/24"
}

variable "subnet_display_name" {
    type = string
    description = "Kubernetes Cluster display name"
}

variable "subnet_dns_label" {
    type = string
    description = "Subnet DNS label"
}
