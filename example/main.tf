terraform {
  backend "s3" {
    bucket = "ops-config-mgmt"
    region = "us-east-1"
    key    = "terraform-state/dirt-simple.io/terraform-aws-certificate-manager/terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
  version = "~> 1.50"
}

module "cnames" {
  source                = "github.com/dirt-simple/terraform-aws-certificate-manager"
  top_level_domain_name = "dirt-simple.io"
}

output "options" {
  value = "${module.cnames.certificate_arn}"
}
