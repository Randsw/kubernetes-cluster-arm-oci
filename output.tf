# output "cp-session-output"{
#     value = data.oci_bastion_session.cp_session_data.ssh_metadata["command"]
# }

# output "worker1-session-output"{
#     value = data.oci_bastion_session.worker1_session_data.ssh_metadata["command"]
# }

# output "worker2-session-output"{
#     value = data.oci_bastion_session.worker2_session_data.ssh_metadata["command"]
# }

output "cp-public-ip"{
    value = module.kube_cp_instance_flex.public_ip[0]
}

output "worker1-public-ip"{
    value = module.kube_worker_instance_flex.public_ip[0]
}

output "worker2-public-ip"{
    value = module.kube_worker_instance_flex.public_ip[1]
}

output "lb-public-ip"{
    value = oci_load_balancer_load_balancer.kube_load_balancer.ip_address_details[0].ip_address
}

locals {
  inventory_rendered_content = templatefile("${path.module}/inventory_ansible.tftpl", 
  {
    k8s_control_plane_ip = "${module.kube_cp_instance_flex.public_ip[0]}"
    k8s_worker1_ip = "${module.kube_worker_instance_flex.public_ip[0]}"
    k8s_worker2_ip = "${module.kube_worker_instance_flex.public_ip[1]}"
  })
}

resource "local_file" "inventories" {
  content = local.inventory_rendered_content
  filename = "${path.module}/ansible/inventories/k8s-cluster/hosts.yml"
}