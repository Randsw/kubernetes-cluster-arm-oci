resource "oci_core_security_list" "k8s_security_list" {
    compartment_id = data.oci_identity_compartments.kube_compartments.compartments[0].id
    vcn_id = module.vcn.vcn_id 
    display_name = "${var.label_prefix}-${var.security_list_name}"
    freeform_tags = var.freeform_tags

    ingress_security_rules {
        protocol      = "6"
        source        = var.k8s_subnet_cidr
        description   = "Allow all tcp connection in subnet"
     }

    ingress_security_rules {
        protocol      = "17"
        source        = var.k8s_subnet_cidr
        description   = "Allow all udp connection in subnet"
     }

    ingress_security_rules {
        protocol      = "1"
        source        = var.k8s_subnet_cidr
        description   = "Allow ping from subnet"
    }

    ingress_security_rules {
        protocol      = "6"
        source        = "0.0.0.0/0"
        description   = "Allow http connection"
        tcp_options {
            min = "80"
            max = "80"
        }
     }

    ingress_security_rules {
        protocol      = "6"
        source        = "0.0.0.0/0"
        description   = "Allow https connection"
        tcp_options {
            min = "443"
            max = "443"
        }
    }

    ingress_security_rules {
        protocol      = "17"
        source        = "0.0.0.0/0"
        description   = "Allow ntp connection"
        tcp_options {
            min = "123"
            max = "123"
        }
     }
    ingress_security_rules {
        protocol    = "1"
        source      = "172.16.0.0/16"
        description = "ICMP traffic for: 3 Destination Unreachable"
        icmp_options {
            code = -1
            type = 3
            }
        }
    ingress_security_rules {
        protocol    = "1"
        source      = "0.0.0.0/0"
        description = "ICMP traffic for: 3, 4 Destination Unreachable: Fragmentation Needed and Don't Fragment was Set"
        icmp_options {
            code = 4
            type = 3
            }
        }
    ingress_security_rules {
        protocol    = "6"
        source      = "0.0.0.0/0"
        description = "Allow ssh connection"
        tcp_options {
            max = 22
            min = 22
            }
        }

    egress_security_rules {
        protocol      = "6"
        destination   = "0.0.0.0/0"
        description   = "Allow output tcp connection"
     }
    egress_security_rules {
        protocol      = "17"
        destination   = var.k8s_subnet_cidr
        description   = "Allow output udp connection in subnet"
     }
    egress_security_rules {
        protocol      = "1"
        destination        = var.k8s_subnet_cidr
        description   = "Allow ping from subnet"
    }

    egress_security_rules {
        protocol      = "17"
        destination   = "0.0.0.0/0"
        description   = "NTP egress"
        udp_options {
            min = "123"
            max = "123"
        }
     }
}