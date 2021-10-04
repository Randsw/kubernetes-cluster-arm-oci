terraform {
   backend "s3" {
    endpoint                    = "https://frd8bsyrgar7.compat.objectstorage.eu-frankfurt-1.oraclecloud.com"
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true
    skip_credentials_validation = true
    bucket                      = "tf-state"
    key                         = "kubernetes-oci/terraform.tfstate"
    region                      = "eu-frankfurt-1"
  }
  required_providers {
    oci = {
        source  = "hashicorp/oci"
        version = ">= 4.0.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "~> 0.5"
    }
  }
}

data "oci_identity_compartments" "vpn_compartments" {
    compartment_id = data.sops_file.secret.data["tenancy"]
    access_level = "ACCESSIBLE"
    name = var.compartment_name
    state = var.compartment_state
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = data.oci_identity_compartments.vpn_compartments.compartments[0].id
}