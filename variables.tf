variable "compartment_name" {
    type = string
    description = "Name of existing compartment we want to use"
}

variable "compartment_state" {
    type = string  
    default = "ACTIVE"
    description = "State of existing compartment we want to use"
}