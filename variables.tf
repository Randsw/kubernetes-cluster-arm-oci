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
    default = [ "172.16.0.0/16" ]
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
    default = "172.16.10.0/24"
}

variable "subnet_display_name" {
    type = string
    description = "Kubernetes Cluster display name"
}

variable "subnet_dns_label" {
    type = string
    description = "Subnet DNS label"
}

variable "kube_cp_instance_display_name" {
    type = string
    description = "Kubernetes control plane instance name"
}

variable "kube_worker_instance_display_name" {
    type = string
    description = "Kubernetes worker instance name"
}

variable "instance_shape" {
    type = string
    description = "Instance shape"
    default = "VM.Standard.A1.Flex"
}

variable "region" {
  default = "eu-frankfurt-1" 
  description = "Tenancy region"
}

variable "image_id" {
  type = map(string)
  description = "OS Image ID"
  default = {
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa4e2ghww37p3owr7pxtz6uirsdljbegjaejgm7vmnjqyumvqg2evq"
  }
}

variable "block_storage_sizes_in_gbs" {
    type = string
    description = "Size of block storage in Gb"
    default = "50"
}

variable "instance_ad_number" {
    type = number
    description = "The availability domain number of the instance. If none is provided, it will start with AD-1 and continue in round-robin."
    default = 1
}

variable "ssh_public_keys_path" {
    type = string
    description = "Path to ssh public key"
}

variable "kube_cp_private_ips" {
    type = list(string)
    description = "List of private ip for control plane instances"
}

variable "kube_worker_private_ips" {
    type = list(string)
    description = "List of private ip for control plan instances"
}

variable "load_balancer_display_name" {
    type = string
    description = "Load balancer display name"
}

variable "load_balancer_shape" {
    type = string
    description = "Load balancer shape"
    default = "10 Mbps"
}

variable "backend_set_name" {
    type = string
    description = "Load balancer backend set display name"
}

variable "listener_name" {
    type = string
    description = "Load balancer listner name"
}

variable "backend_name" {
    type = string
    description = "NLB backend name"
}

variable "bastion_name" {
    type = string
    description = "Bastion-name"
}

variable "session_session_ttl_in_seconds"{
    type = number
    description = "Basstion session in seconds"
    default = 10800
}