# Copy html files to S3 bucket
aws s3 sync html/ s3://mcmcloudfrontstaticwebsite
aws s3 sync html/ s3://mcmcloudfrontbasicbucket