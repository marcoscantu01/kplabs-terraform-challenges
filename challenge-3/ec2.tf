resource "aws_instance" "instances" {
    for_each = var.instance_config
    
    instance_type = each.value.instance_type
    ami = each.value.ami

    tags = {
      name = each.key
    }
}