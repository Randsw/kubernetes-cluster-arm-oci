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
    enable_ipv6                     = "false"
    vcn_cidrs                       = var.vcn_cidrs # List of IPv4 CIDRs
    vcn_dns_label                   = var.vcn_dns_label
    vcn_name                        = var.vcn_name

    # gateways parameters
    internet_gateway_display_name   = var.internet_gateway_display_name
    internet_gateway_route_rules    = var.internet_gateway_route_rules
}