module "bastion" {
  source              = "oracle-terraform-modules/bastion/oci"
  version             = "3.0.0"
    tenancy_id        = data.sops_file.secret.data["tenancy"]
  compartment_id      = data.oci_identity_compartments.kube_compartments.compartments[0].id
  label_prefix        = var.label_prefix
  ig_route_id         = module.vcn.ig_route_id

  vcn_id              = module.vcn.vcn_id

  ssh_public_key_path = var.ssh_public_keys_path

  upgrade_bastion     = false

  freeform_tags       = var.freeform_tags

providers = {
    oci.home = oci
  }
}
