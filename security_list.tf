resource "oci_core_security_list" "k8s_security_list" {
    compartment_id = data.oci_identity_compartments.kube_compartments.compartments[0].id
    vcn_id = module.vcn.vcn_id 
    display_name = var.security_list_name
    freeform_tags = var.freeform_tags

    ingress_security_rules {
        protocol = "6"
        source   = "0.0.0.0/0"
        description = "Allow http connection"
        tcp_options {
            min = "80"
            max = "80"
        }
     }

        ingress_security_rules {
        protocol = "6"
        source   = "0.0.0.0/0"
        description = "Allow https connection"
            tcp_options {
                min = "443"
                max = "443"
            }
        }

    # ingress_security_rules {
    #     protocol = "6"
    #     source   = data.oci_core_subnets.public_subnets.subnets[0].cidr_block
    #     description = "Allow connection to k8s api from public subnet through OpenVPN"
    #     tcp_options {
    #         min = "6443"
    #         max = "6443"
    #     }
    #  }

    ingress_security_rules {
        protocol = "17"
        source   = "0.0.0.0/0"
        description = "Allow ntp connection"
        tcp_options {
            min = "123"
            max = "123"
        }
     }

    ingress_security_rules {
        protocol = "4"
        source   = var.k8s_subnet_cidr
        description = "Allow IPIP connection"
     }

     egress_security_rules {
        protocol = "6"
        destination   = "0.0.0.0/0"
        description = "Allow output tcp connection"
     }

    egress_security_rules {
        protocol = "17"
        destination   = "0.0.0.0/0"
        description = "NTP egress"
        udp_options {
            min = "123"
            max = "123"
        }
     }
    egress_security_rules {
        protocol = "4"
        destination   = var.k8s_subnet_cidr
        description = "IPIP private subnet egress block"
     }
}