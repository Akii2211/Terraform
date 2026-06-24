resource "aws_instance" "devops" {
  ami                    = "ami-0b6d9d3d33ba97d99"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0228cdd58be6dafc0"]
  delete_on_termination  = true
  volume_type            = "gp2"
  volume_size            = 10


  tags = {
    Name     = "MyTerraformEC2"
    purpose  = "webserverinstalled"
  }
}
