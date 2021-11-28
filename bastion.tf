# resource "oci_bastion_bastion" "kube_bastion" {
#     #Required
#     bastion_type = "standard"
#     compartment_id = data.oci_identity_compartments.kube_compartments.compartments[0].id
#     target_subnet_id = oci_core_subnet.kube-subnet.id

#     #Optional
#     client_cidr_block_allow_list = ["0.0.0.0/0"]
#     freeform_tags = var.freeform_tags
#     name = "${var.label_prefix}${var.bastion_name}"
# }