Deploy Website on s3 bucket using terraform"Write a Terraform configuration to deploy a static website on an AWS S3 bucket. Ensure the following requirements are met:"

S3 Bucket Configuration:

The bucket should be named my-website-bucket (or a unique name).

Enable the bucket for static website hosting.

Set the index.html as the index document and error.html as the error document.

Allow public read access to the bucket for website hosting.

Static Website Files:

Upload the index.html and error.html files to the S3 bucket using Terraform.

Ensure both files are publicly accessible.

Outputs:

Output the website URL for the static site.


Bonus:

Enable versioning on the S3 bucket.
Add tags to the bucket indicating the environment is Development.