compartment_name = "Kubernetes-cluster"

vcn_name = "Kubernetes-cluster"

vcn_dns_label = "kube"

vcn_cidrs = ["172.16.0.0/16"]

freeform_tags = {
                "app" = "k8s"
                }

label_prefix = "kube"

internet_gateway_display_name = "Kube IG"

internet_gateway_route_rules = [
                                { 
                                  destination       = "0.0.0.0/0"
                                  destination_type  = "CIDR_BLOCK"
                                  network_entity_id = "internet_gateway"
                                  description       = "Internet route rule"
                                }
                               ]