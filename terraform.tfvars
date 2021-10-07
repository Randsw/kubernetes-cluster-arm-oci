compartment_name = "Kubernetes-cluster"

vcn_name = "vcn"

vcn_dns_label = "kube"

vcn_cidrs = ["172.16.0.0/16"]

freeform_tags = {
                "app" = "k8s"
                }

label_prefix = "kube"

internet_gateway_display_name = "internet-gateway"

security_list_name = "security-list"

subnet_display_name= "subnet"

subnet_dns_label = "cluster"

kube_cp_instance_display_name = "cp"

kube_worker_instance_display_name = "worker"

ssh_public_keys_path = "~/.ssh/kube-oci.pub"

kube_cp_private_ips = ["172.19.0.2"]

kube_worker_private_ips = ["172.19.0.3", "172.19.0.4"]

load_balancer_display_name = "lb"

backend_set_name = "backend-set"

listener_name = "listner"