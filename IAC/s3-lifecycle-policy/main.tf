resource "random_string" "random" {
  length = 6
  special = false
  upper = false         
}


resource "aws_s3_bucket" "s3_bucket" {
  bucket = random_string.random.result
}

resource "aws_s3_object" "s3_object" {
  bucket = aws_s3_bucket.s3_bucket.id
  key    = "example.txt"
  content = "This is an example file."
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecyle-rule" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    id     = "Transition to Standard-IA after 30 days"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = 365
    }
  }
  
}