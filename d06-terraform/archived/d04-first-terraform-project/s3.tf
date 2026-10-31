
// The `resource` block is used by Terraform to create infastructure
// The syntax is: 
// resource "resource_type" "a name of your choosing to identify the resource"
// The format of "resource_type", is "provider_resource_name"

// E.g. The line below means:
// Create an `id` using the provider `random`, 
// and I want to be able to use the resource in this file using the name
// `bucket_sufix` 
resource "random_id" "bucket_suffix" {
  // Length of the random id in bytes 
  byte_length = 6
}

// `example_bucket` is the name used to identify and target this resource
// in the Terraform file. Terraform syntax uses underscores
resource "aws_s3_bucket" "example_bucket" {

  // This where you set the name for the s3 bucket on AWS
  // AWS does not not allow underscores in the name of a bucket,
  // so that's why and underscore is used.
  bucket = "example-bucket-${random_id.bucket_suffix.hex}"
}

// Since Terraform is creating a random identifier for the bucket name,
// the `output` block allows us to get the name of the bucket so that it can
// be indentified.
output "bucket_name" {

  // `.bucket` gives you the name of the bucket.
  value = aws_s3_bucket.example_bucket.bucket
}
