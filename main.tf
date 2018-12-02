variable "top_level_domain_name" {
  description = "The TLD to create certs for"
}

data "aws_route53_zone" "zone" {
  name = "${var.top_level_domain_name}."
}

resource "aws_acm_certificate" "cert" {
  domain_name               = "${var.top_level_domain_name}"
  subject_alternative_names = ["*.${var.top_level_domain_name}"]
  validation_method         = "DNS"
}

// We only care about the first record. The second one for *.tld is same CNAME so ignore it
resource "aws_route53_record" "validation_record" {
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  name    = "${lookup(aws_acm_certificate.cert.domain_validation_options[0], "resource_record_name")}"
  type    = "${lookup(aws_acm_certificate.cert.domain_validation_options[0], "resource_record_type")}"
  records = ["${lookup(aws_acm_certificate.cert.domain_validation_options[0], "resource_record_value")}"]
  ttl     = "300"
}

output "certificate_arn" {
  value = "${aws_acm_certificate.cert.arn}"
}
