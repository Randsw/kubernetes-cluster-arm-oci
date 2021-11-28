module "kube_cp_instance_flex" {
  source = "oracle-terraform-modules/compute-instance/oci"
  version                     = "2.2.0"
  # general oci parameters
  compartment_ocid            = data.oci_identity_compartments.kube_compartments.compartments[0].id
  freeform_tags               = var.freeform_tags
  # compute instance parameters
  ad_number                   = var.instance_ad_number
  instance_count              = 1
  instance_display_name       = "${var.label_prefix}-${var.kube_cp_instance_display_name}"
  shape                       = var.instance_shape
  source_ocid                 = "${var.image_id[var.region]}"
  source_type                 = "image"
  instance_flex_memory_in_gbs = 6 # only used if shape is Flex type
  instance_flex_ocpus         = 2 # only used if shape is Flex type
  hostname_label              = "${var.label_prefix}-${var.kube_cp_instance_display_name}"
  # operating system parameters
  ssh_public_keys             = "${file(var.ssh_public_keys_path)}"
  # networking parameters
  assign_public_ip            = true
  subnet_ocids                = [oci_core_subnet.kube-subnet.id]
  private_ips                 = var.kube_cp_private_ips
  skip_source_dest_check      = true
  vnic_name                   = "${var.label_prefix}-${var.kube_cp_instance_display_name}-VNIC"
  # storage parameters
  #block_storage_sizes_in_gbs = var.block_storage_sizes_in_gbs
}

module "kube_worker_instance_flex" {
  source = "oracle-terraform-modules/compute-instance/oci"
  version                     = "2.2.0"
  # general oci parameters
  compartment_ocid            = data.oci_identity_compartments.kube_compartments.compartments[0].id
  freeform_tags               = var.freeform_tags
  # compute instance parameters
  ad_number                   = var.instance_ad_number
  instance_count              = 2
  instance_display_name       = "${var.label_prefix}-${var.kube_worker_instance_display_name}"
  shape                       = var.instance_shape
  source_ocid                 = "${var.image_id[var.region]}"
  source_type                 = "image"
  instance_flex_memory_in_gbs = 9 # only used if shape is Flex type
  instance_flex_ocpus         = 1 # only used if shape is Flex type
  hostname_label              = "${var.label_prefix}-${var.kube_worker_instance_display_name}"
  # operating system parameters
  ssh_public_keys             = "${file(var.ssh_public_keys_path)}"
  # networking parameters
  assign_public_ip            = true
  subnet_ocids                = [oci_core_subnet.kube-subnet.id]
  private_ips                 = var.kube_worker_private_ips
  skip_source_dest_check      = true
  vnic_name                   = "${var.label_prefix}-${var.kube_worker_instance_display_name}-VNIC"
  # storage parameters
  #block_storage_sizes_in_gbs = var.block_storage_sizes_in_gbs
}