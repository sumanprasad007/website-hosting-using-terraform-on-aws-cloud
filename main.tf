#create s3 bucket
resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucketname
}

# create s3 bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "bucket_ownership_controls" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# create a s3 bucket public access block - public access allowed 
resource "aws_s3_bucket_public_access_block" "bucket_public_access" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# create s3 bucket acl, provides public read and create when ownership and access block are already created
resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucket_ownership_controls,
    aws_s3_bucket_public_access_block.bucket_public_access,
  ]

  bucket = aws_s3_bucket.mybucket.id
  acl    = "public-read"
}

# creating object & passing values
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.mybucket.id
  key          = "index.html"
  source       = "index.html"
  acl          = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.mybucket.id
  key          = "error.html"
  source       = "error.html"
  acl          = "public-read"
  content_type = "text/html"
  
}

# Creating object for profile image
resource "aws_s3_object" "profile" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "my passport size image.png"
  source = "my passport size image.png"
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.mybucket.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  depends_on = [aws_s3_bucket_acl.example]
}

# --------------------------------------------------------------------------------------

# # For deploying the fully function website with directories

# resource "aws_s3_bucket_object" "static_website" {
#   bucket = aws_s3_bucket.mybucket.bucket
#   acl    = "public-read"
#   key    = "static_website/"

# # path of the directory
#   source = "${path.module}/${var.static_website_folder}" # Use the path to your folder

#   content_type = "binary/octet-stream" # Default content type for folders (binary)
# }