resource "aws_instance" "pubec2" {
  ami                         = var.ami
  instance_type               = "t2.small"
  key_name                    = aws_key_pair.public_key_pair.id
  vpc_security_group_ids      = [aws_security_group.publicgroup1.id]
  subnet_id                   = module.network.public_sub_1id
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 10
    delete_on_termination = true
  }

  tags = {
    Name = "${var.workSpace}-public"
  }
  provisioner "local-exec" {

      command = " echo ${self.public_ip}"

  }


}

resource "aws_instance" "privc2" {
  ami                         = var.ami
  instance_type               = "t2.small"
  key_name                    = aws_key_pair.public_key_pair.id
  vpc_security_group_ids      = [aws_security_group.group2.id]
  subnet_id                   = module.network.private_sub_1id
  associate_public_ip_address = false

  root_block_device {
    volume_size           = 10
    delete_on_termination = true
  }

  tags = {
    Name = "${var.workSpace}-private"
  }
}