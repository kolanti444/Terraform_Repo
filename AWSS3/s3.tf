resource "aws_s3_bucket" "sample" {
  bucket = "my-tf-test-bucket-21-02-2023"

  tags = {
    Name = "My-tf-bucket-new"
  }
}