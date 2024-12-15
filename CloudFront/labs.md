# CloudFront labs

## Create S3 bucket distribution
1. Create S3 bucket
2. Turn off ```Block all public access``` on the bucket settings page
3. Add bucket policy to allow public access
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Allow public access to all objects",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::mcmcloudfronts3bucket/*"
        }
    ]
}
```
4. Upload image to bucket
5. Create CloudFront distibution with the S3 bucket as the Origin
6. Browse to the distribution domain name and verify access to the image.

## Create S3 static website distribution
1. Create S3 bucket
2. Turn off ```Block all public access``` on the bucket settings page
3. Add bucket policy to allow public access
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Allow public access to website files",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": [
                "arn:aws:s3:::mcmstataticwebsitebucket/index.html",
                "arn:aws:s3:::mcmstataticwebsitebucket/*.jpeg"
            ]
        }
    ]
}
```
4. Upload index.html and sloth.jpeg to the S3 bucket
5. Enable ```Static website hosting``` and configure index.html as the index document.
6. Copy the S3 Bucket website endpoint URL from with the bucket properties page
7. Create CloudFront distibution and paste the Bucket website endpoint URL in the Origin field
8. Browse to the distribution domain name and verify access to the website.
