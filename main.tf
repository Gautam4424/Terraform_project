terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.80.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}
provider "aws" {
  region = "ap-south-1"

}

resource "random_id" "rand_id" {
  byte_length = 8
}


resource "aws_s3_bucket" "my-website" {
  bucket = "my-website-${random_id.rand_id.hex}"
}

resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.my-website.bucket

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

}

resource "aws_s3_bucket_policy" "my-web-app-policy" {
  bucket = aws_s3_bucket.my-website.bucket
  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid = "PublicReadGetObject",
          Effect = "Allow",
          Principal = "*",
          Action = "s3:GetObject",
          Resource = "arn:aws:s3:::${aws_s3_bucket.my-website.bucket}/*"
          
        }
      ]
    }
  )


}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.my-website.bucket
  source = "./my-website/index.html"
  key    = "index.html"
  content_type = "text/html"

}


resource "aws_s3_object" "css_file" {
  bucket = aws_s3_bucket.my-website.bucket
  source = "./my-website/style.css"
  key    = "style.css"
  content_type = "text/css"

}


resource "aws_s3_bucket_website_configuration" "my-website-app" {
  bucket = aws_s3_bucket.my-website.bucket

  index_document {
    suffix = "index.html"
  }
}

output "website-url" {
    value = aws_s3_bucket_website_configuration.my-website-app.website_endpoint
  
}