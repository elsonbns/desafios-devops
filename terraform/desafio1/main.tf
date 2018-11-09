resource "aws_instance" "desafio1" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name = "terraform"
  vpc_security_group_ids = ["${aws_security_group.permite80e443e22.id}"]

  connection {
    user = "${var.aws_instance_user}"
    private_key = "terraform.pem"
  }

  provisioner "remote-exec" {
        inline = [
            "sudo apt-get update",
            "sudo apt-get install docker-io",
            "source /etc/bash_completion.d/docker.io",
            "service docker.io start",
            "usermod -aG docker ubuntu",
            "docker pull httpd"
        ]
    }

  tags {
    Name = "desafio1"
  }
}

output "IP Publico: " {
  value = "${aws_instance.desafio1.public_ip}"
}