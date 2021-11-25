output "cp-session-output"{
    value = data.oci_bastion_session.cp_session_data.ssh_metadata["command"]
}

output "worker1-session-output"{
    value = data.oci_bastion_session.worker1_session_data.ssh_metadata["command"]
}

output "worker2-session-output"{
    value = data.oci_bastion_session.worker2_session_data.ssh_metadata["command"]
}