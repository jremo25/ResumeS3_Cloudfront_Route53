#Create the s3 bucket
resource "aws_s3_bucket" "resume" {
  bucket = "resumeforhuey.click"

}
#Upload the files into the bucket
resource "aws_s3_bucket_object" "resume" {
    bucket = aws_s3_bucket.resume.id
    for_each = {
        "error.html"  = "text/html",
        "index.html"  = "text/html",
        "styles.css"  = "text/css" ,
        "resume.xml"  = "text/xml" 
    }
    key = each.key
    source = "./${each.key}"
    content_type = each.value
    etag = filemd5("./${each.key}")
}
#Disable pubic access block
resource "aws_s3_bucket_public_access_block" "resume" {
  bucket = aws_s3_bucket.resume.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false 
  restrict_public_buckets = false 
}

resource "aws_s3_bucket_policy" "resume" {
  bucket = aws_s3_bucket.resume.id
  policy = file("s3policy.json")

}
resource "aws_s3_bucket_website_configuration" "huey" {
  bucket = aws_s3_bucket.resume.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}