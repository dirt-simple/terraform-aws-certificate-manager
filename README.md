# terraform-aws-certificate-manager

This module will create a certificate for the TLD with a wildcard. It will create the validation CNAME record for you.


## Module Usage
```
module "cert" {
  source                = "github.com/dirt-simple/terraform-aws-certificate-manager"
  top_level_domain_name = "dirt-simple.io"
}

output "certificate_arn" {
  value = "${module.cert.certificate_arn}"
}
```

## Argument Reference
The following arguments are supported:

* `top_level_domain_name` - The top level domain name. Example: dirt-simple.io

## Attributes Reference
In addition to all arguments above, the following attributes are exported:

* `certificate_arn` - The ARN for the created ACM Certificate.

