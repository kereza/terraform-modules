data "terraform_remote_state" "vpc" {
 backend = "s3"
 config {
  bucket = "terraform-up-and-running-state-kereza"
  key = "global/vpc/terraform.tfstate"
  region = "us-east-1"
 }
}

resource "aws_subnet" "kereza_subnet" {
 vpc_id = "${data.terraform_remote_state.vpc.vpc_main}"
 cidr_block = "${var.subnet}"
 availability_zone = "${var.availability-zone}"
 tags {
  Name = "${var.subnet-name}"
 }
}

