# ##############################################################################################################
# resource "oci_network_load_balancer_network_load_balancer" "kube_load_balancer" {
#     #Required
#     compartment_id = data.oci_identity_compartments.kube_compartments.compartments[0].id
#     display_name = "${var.label_prefix}-${var.load_balancer_display_name}"
#     subnet_id = oci_core_subnet.kube-subnet.id
#     freeform_tags = var.freeform_tags
#     is_preserve_source_destination = true
#     is_private = false
# }

# resource "oci_network_load_balancer_backend_set" "kube_backend_set-https" {
#     #Required
#     health_checker {
#         #Required
#         protocol = "TCP"

#         #Optional
#         interval_in_millis = 1000
#         port = 443
#         retries = 3
#         timeout_in_millis = 300

#     }
#     name = "${var.label_prefix}-${var.backend_set_name}-https"
#     network_load_balancer_id = oci_network_load_balancer_network_load_balancer.kube_load_balancer.id
#     policy = "FIVE_TUPLE"
# }

# resource "oci_network_load_balancer_backend_set" "kube_backend_set-http" {
#     #Required
#     health_checker {
#         #Required
#         protocol = "TCP"

#         #Optional
#         interval_in_millis = 1000
#         port = 80
#         retries = 3
#         timeout_in_millis = 300

#     }
#     name = "${var.label_prefix}-${var.backend_set_name}-http"
#     network_load_balancer_id = oci_network_load_balancer_network_load_balancer.kube_load_balancer.id
#     policy = "FIVE_TUPLE"
# }

# resource "oci_network_load_balancer_backend" "kube_worker1-https" {
#     #Required
#     backend_set_name = oci_network_load_balancer_backend_set.kube_backend_set-https.name
#     network_load_balancer_id = oci_network_load_balancer_network_load_balancer.kube_load_balancer.id
#     port = 443

#     #Optional
#     ip_address = var.kube_worker_private_ips[0]
#     name = "${var.label_prefix}-${var.backend_name}1-https"
# }

# resource "oci_network_load_balancer_backend" "kube_worker2-https" {
#     #Required
#     backend_set_name = oci_network_load_balancer_backend_set.kube_backend_set-https.name
#     network_load_balancer_id = oci_network_load_balancer_network_load_balancer.kube_load_balancer.id
#     port = 443

#     #Optional
#     ip_address = var.kube_worker_private_ips[1]
#     name = "${var.label_prefix}-${var.backend_name}2-https"
# }

# resource "oci_network_load_balancer_backend" "kube_worker1-http" {
#     #Required
#     backend_set_name = oci_network_load_balancer_backend_set.kube_backend_set-http.name
#     network_load_balancer_id = oci_network_load_balancer_network_load_balancer.kube_load_balancer.id
#     port = 80

#     #Optional
#     ip_address = var.kube_worker_private_ips[0]
#     name = "${var.label_prefix}-${var.backend_name}1-http"
# }

# resource "oci_network_load_balancer_backend" "kube_worker2-http" {
#     #Required
#     backend_set_name = oci_network_load_balancer_backend_set.kube_backend_set-http.name
#     network_load_balancer_id = oci_network_load_balancer_network_load_balancer.kube_load_balancer.id
#     port = 80

#     #Optional
#     ip_address = var.kube_worker_private_ips[1]
#     name = "${var.label_prefix}-${var.backend_name}2-http"

# }

# resource "oci_network_load_balancer_listener" "kube_listener-http" {
#     #Required
#     default_backend_set_name = oci_network_load_balancer_backend_set.kube_backend_set-http.name
#     name = "${var.label_prefix}-${var.listener_name}-http"
#     network_load_balancer_id = oci_network_load_balancer_network_load_balancer.kube_load_balancer.id
#     port = 80
#     protocol = "TCP"
# }

# resource "oci_network_load_balancer_listener" "kube_listener-https" {
#     #Required
#     default_backend_set_name = oci_network_load_balancer_backend_set.kube_backend_set-https.name
#     name = "${var.label_prefix}-${var.listener_name}-https"
#     network_load_balancer_id = oci_network_load_balancer_network_load_balancer.kube_load_balancer.id
#     port = 443
#     protocol = "TCP"
# }