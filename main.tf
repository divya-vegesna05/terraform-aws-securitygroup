resource "aws_security_group" "allow-tls" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = var.sg_ingress_rules
    content {
     from_port         = ingress.value["from_port"]
     protocol          = ingress.value["protocol"]
     to_port           = ingress.value["to_port"]
     cidr_blocks       = ingress.value["cidr_blocks"]
    }
}
    egress {
    from_port          = 0
    to_port            = 0
    protocol           = "-1"
    cidr_blocks        = ["0.0.0.0/0"]
  }

tags = merge(
    var.common_tags,
    var.sg_tags,
    {
      Name = "${local.name}-${var.sg_name}"
    }
  )
}
