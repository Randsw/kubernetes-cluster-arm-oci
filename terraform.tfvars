compartment_name = "Kubernetes-cluster"

vcn_name = "vcn"

vcn_dns_label = "kube"

vcn_cidrs = ["172.16.0.0/16"]

freeform_tags = {
                "app" = "k8s"
                }

label_prefix = "kube"

internet_gateway_display_name = "Kube IG"
