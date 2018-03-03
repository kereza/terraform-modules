data "terraform_remote_state" "subnet" {
 backend = "s3"
 config {
  bucket = "terraform-up-and-running-state-kereza"
  key = "${var.remote_key}"
  region = "us-east-1"
 }
}

resource "aws_network_interface" "kereza_ani" {
 subnet_id = "${data.terraform_remote_state.subnet.subnet1_output}"
 private_ips = ["${var.private_ips}"]
 tags {
  Name = "primary_network_interface"
 }
}

resource "aws_instance" "kereza_ec2" {
 ami = "${var.ami}"
 instance_type = "${var.instance_type}"
 network_interface {
  network_interface_id = "${aws_network_interface.kereza_ani.id}"
  device_index = 0
 }
}

