variable "ami" {
    description = "They are playing cricket"
    type = string
    default = " "
  
}
variable "instance_type" {
    description = "They are playing cricket"
    type = string
    default = " "
  
}
variable "key_name" {
    type = string
    default = " "
  
}
variable "sandboxes" {
  type    = list(string)
  default = ["dev"]
}