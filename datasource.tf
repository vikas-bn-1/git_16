data "aws_route53_zone" "rootdomain" {
  name         = var.hostname_domain_name
  private_zone = false
}
