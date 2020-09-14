resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-pgb"
  acl    = "private"
  versioning {
    enabled = true
  }
}
