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