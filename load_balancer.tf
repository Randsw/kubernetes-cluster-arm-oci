resource "oci_load_balancer_load_balancer" "kube_load_balancer" {
    #Required
    compartment_id = data.oci_identity_compartments.kube_compartments.compartments[0].id
    display_name = "${var.label_prefix}-${var.load_balancer_display_name}"
    shape = var.load_balancer_shape
    subnet_ids = [oci_core_subnet.kube-subnet.id]
    #Optional
    freeform_tags = var.freeform_tags
    ip_mode = "IPV4"
    is_private = false
}

resource "oci_load_balancer_backend_set" "kube_backend_set" {
    #Required
    health_checker {
        #Required
        protocol = "tcp"

        #Optional
        interval_ms = 1000
        port = 443
        retries = 3
        timeout_in_millis = 3000
    }
    load_balancer_id = oci_load_balancer_load_balancer.kube_load_balancer.id
    name = "${var.label_prefix}-${var.backend_set_name}"
    policy = "ROUND_ROBIN"
}

resource "oci_load_balancer_backend" "kube_worker1" {
    #Required
    backendset_name = oci_load_balancer_backend_set.kube_backend_set.name
    ip_address = var.kube_worker_private_ips[0]
    load_balancer_id = oci_load_balancer_load_balancer.kube_load_balancer.id
    port = 443
}

resource "oci_load_balancer_backend" "kube_worker2" {
    #Required
    backendset_name = oci_load_balancer_backend_set.kube_backend_set.name
    ip_address = var.kube_worker_private_ips[1]
    load_balancer_id = oci_load_balancer_load_balancer.kube_load_balancer.id
    port = 443
}

resource "oci_load_balancer_listener" "kube_listener_http" {
    #Required
    default_backend_set_name = oci_load_balancer_backend_set.kube_backend_set.name
    load_balancer_id = oci_load_balancer_load_balancer.kube_load_balancer.id
    name = "${var.label_prefix}-${var.listener_name}-http"
    port = 80
    protocol = "tcp"
}

resource "oci_load_balancer_listener" "kube_listener_https" {
    #Required
    default_backend_set_name = oci_load_balancer_backend_set.kube_backend_set.name
    load_balancer_id = oci_load_balancer_load_balancer.kube_load_balancer.id
    name = "${var.label_prefix}-${var.listener_name}-https"
    port = 443
    protocol = "tcp"
}