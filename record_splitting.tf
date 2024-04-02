
locals {
  # If a record in var.records is longer than 255 characters, it will be split into multiple records with \"\" between them.
  # See https://github.com/hashicorp/terraform-provider-aws/issues/14941 for more information
  records = [for record in var.records : replace(record, "/(.{255})/", "$1\"\"")]
}

variable "records" {
  type        = list(string)
  description = "(Required for non-alias records) A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM, add \"\" inside the Terraform configuration string."
  default     = [
    "testing123",
    "fdsafdfjkdslafjlkdsjalfkjdsalkfjdslkafjldksajflkdsjaflkdjsalkfjdslkafjdlksajflkdsajflkdsajflkdsjalkfjdsalkfjdlksajflkdsajfodehrtoierwqaoithewoiafhdoksajfoidsajfoidsjaoifjdsaoifjdsoilkjfdlksajflkdsjalkfjdslkajflkdsajflkdjsalkfjdslkajfdlksajflkdjsalkfjdsoik afjoidsajfoidsjaofijdsaoifjdoisaf,sdaj.,fjds.,afjds.,ajfkodsafoidsfdosiajfoidsafoidsayhfdsyhafhdskjafhduksayfudisayfiudsayfuidysaoiufuydsoaifydsoiayfdoisayfoidsayfoidsyafoiydsaoifydsaoiufydsoiafydoisayfoidsayfoidsayfoidsyaoifdysaoifydsaoifydsoiyfdoisayfoidsayfoidsayfoidsyaoifydsaoifyodsayfoidsyaifodysaoifydsaoifydso"
  ]
}