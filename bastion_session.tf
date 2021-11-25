resource "oci_bastion_session" "cp-session" {
    #Required
    bastion_id = oci_bastion_bastion.kube_bastion.id
    key_details {
        #Required
        public_key_content = "${file(var.ssh_public_keys_path)}"
    }
    target_resource_details {
        #Required
        session_type = "PORT_FORWARDING"
        target_resource_id = module.kube_cp_instance_flex.instance_id[0] 

        target_resource_port = 22
    }
    #Optional
    display_name = "cp-session"
    session_ttl_in_seconds = var.session_session_ttl_in_seconds
}

resource "oci_bastion_session" "worker1-session" {
    #Required
    bastion_id = oci_bastion_bastion.kube_bastion.id
    key_details {
        #Required
        public_key_content = "${file(var.ssh_public_keys_path)}"
    }
    target_resource_details {
        #Required
        session_type = "PORT_FORWARDING"
        target_resource_id = module.kube_worker_instance_flex.instance_id[0] 

        target_resource_port = 22
    }
    #Optional
    display_name = "cp-session"
    session_ttl_in_seconds = var.session_session_ttl_in_seconds
}

resource "oci_bastion_session" "worker2-session" {
    #Required
    bastion_id = oci_bastion_bastion.kube_bastion.id
    key_details {
        #Required
        public_key_content = "${file(var.ssh_public_keys_path)}"
    }
    target_resource_details {
        #Required
        session_type = "PORT_FORWARDING"
        target_resource_id = module.kube_worker_instance_flex.instance_id[1] 

        target_resource_port = 22
    }
    #Optional
    display_name = "worker2-session"
    session_ttl_in_seconds = var.session_session_ttl_in_seconds
}

data "oci_bastion_session" "cp_session_data" {
    #Required
    session_id = oci_bastion_session.cp-session.id
}

data "oci_bastion_session" "worker1_session_data" {
    #Required
    session_id = oci_bastion_session.worker1-session.id
}

data "oci_bastion_session" "worker2_session_data" {
    #Required
    session_id = oci_bastion_session.worker2-session.id
}