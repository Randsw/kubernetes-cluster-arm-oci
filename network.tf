locals {
    security_list_ids = "${split(",", oci_core_security_list.k8s_security_list.id)}" 
}

module "vcn" {
    source                          = "oracle-terraform-modules/vcn/oci"
    version                         = "3.1.0"
    # general oci parameters
    compartment_id                  = data.oci_identity_compartments.kube_compartments.compartments[0].id
    label_prefix                    = var.label_prefix
    freeform_tags                   = var.freeform_tags

    # vcn parameters
    create_drg                      = "false" # boolean: true or false
    create_internet_gateway         = "true"  # boolean: true or false
    lockdown_default_seclist        = "true"  # boolean: true or false
    create_nat_gateway              = "false" # boolean: true or false
    create_service_gateway          = "false" # boolean: true or false
    vcn_cidrs                       = var.vcn_cidrs # List of IPv4 CIDRs
    vcn_dns_label                   = var.vcn_dns_label
    vcn_name                        = var.vcn_name

    # gateways parameters
    internet_gateway_display_name   = var.internet_gateway_display_name
}

resource "oci_core_subnet" "kube-subnet" {
    vcn_id                      = module.vcn.vcn_id 
    compartment_id              = data.oci_identity_compartments.kube_compartments.compartments[0].id

    cidr_block                  = var.k8s_subnet_cidr
    display_name                = "${var.label_prefix}-${var.subnet_display_name}"
    dns_label                   = var.subnet_dns_label
    route_table_id              = module.vcn.ig_route_id #oci_core_route_table.kube_route_table.id
    freeform_tags               = var.freeform_tags
    security_list_ids           = local.security_list_ids
}