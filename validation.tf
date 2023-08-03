resource "aws_instance" "this" {
  ami                     = var.ami
  instance_type           = var.instance_type
  disable_api_stop        = var.disable_api_stop
  disable_api_termination = var.disable_api_termination
}
