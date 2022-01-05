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
    shape_details {
        #Required
        maximum_bandwidth_in_mbps = var.load_balancer_shape_details_maximum_bandwidth_in_mbps
        minimum_bandwidth_in_mbps = var.load_balancer_shape_details_minimum_bandwidth_in_mbps
    }
}

resource "oci_load_balancer_backend_set" "kube_backend_set_http" {
    #Required
    health_checker {
        #Required
        protocol = "TCP"

        #Optional
        interval_ms = 1000
        port = 32080
        retries = 3
        timeout_in_millis = 3000
    }
    load_balancer_id = oci_load_balancer_load_balancer.kube_load_balancer.id
    name = "${var.label_prefix}-${var.backend_set_name}-http"
    policy = "ROUND_ROBIN"
}

resource "oci_load_balancer_backend" "kube_worker1_http" {
    #Required
    backendset_name = oci_load_balancer_backend_set.kube_backend_set_http.name
    ip_address = var.kube_worker_private_ips[0]
    load_balancer_id = oci_load_balancer_load_balancer.kube_load_balancer.id
    port = 32080
}

resource "oci_load_balancer_backend" "kube_worker2_http" {
    #Required
    backendset_name = oci_load_balancer_backend_set.kube_backend_set_http.name
    ip_address = var.kube_worker_private_ips[1]
    load_balancer_id = oci_load_balancer_load_balancer.kube_load_balancer.id
    port = 32080
}


resource "oci_load_balancer_backend_set" "kube_backend_set_https" {
    #Required
    health_checker {
        #Required
        protocol = "TCP"

        #Optional
        interval_ms = 1000
        port = 32443
        retries = 3
        timeout_in_millis = 3000
    }
    load_balancer_id = oci_load_balancer_load_balancer.kube_load_balancer.id
    name = "${var.label_prefix}-${var.backend_set_name}-https"
    policy = "ROUND_ROBIN"
}

resource "oci_load_balancer_backend" "kube_worker1_https" {
    #Required
    backendset_name = oci_load_balancer_backend_set.kube_backend_set_https.name
    ip_address = var.kube_worker_private_ips[0]
    load_balancer_id = oci_load_balancer_load_balancer.kube_load_balancer.id
    port = 32443
}
resource "oci_load_balancer_backend" "kube_worker2_https" {
    #Required
    backendset_name = oci_load_balancer_backend_set.kube_backend_set_https.name
    ip_address = var.kube_worker_private_ips[1]
    load_balancer_id = oci_load_balancer_load_balancer.kube_load_balancer.id
    port = 32443
}
resource "oci_load_balancer_listener" "kube_listener_http" {
    #Required
    default_backend_set_name = oci_load_balancer_backend_set.kube_backend_set_http.name
    load_balancer_id = oci_load_balancer_load_balancer.kube_load_balancer.id
    name = "${var.label_prefix}-${var.listener_name}-http"
    port = 80
    protocol = "TCP"
}

resource "oci_load_balancer_listener" "kube_listener_https" {
    #Required
    default_backend_set_name = oci_load_balancer_backend_set.kube_backend_set_https.name
    load_balancer_id = oci_load_balancer_load_balancer.kube_load_balancer.id
    name = "${var.label_prefix}-${var.listener_name}-https"
    port = 443
    protocol = "TCP"
}