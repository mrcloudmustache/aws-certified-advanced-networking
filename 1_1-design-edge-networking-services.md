# Cloudfront
* Cloudfront is a content delivery network that uses caching and the AWS global backbone to efficiently serve data to viewers.
* Orgins are the source of the data and can either be an S3 origin or Custom origin
* Orgins must have a publicly routable IPv4 address.
* Orgins can be an S3 bucket, Application load balancer or an AWS Lambda function
* Distribution - The configuration unit of Cloudfront. Orgins live within a distribution.
* Edge location - Local caches of your data that are distributed globally
* Reginal edge cache - Larger version of an edge location.
* Arhcitecture - Upload orginal content to an S3 bucket, configure the distribution to use the S3 bucket as the origin, a domain name is assigned to the distribution, deploy the distribution to the cloudfront networks which pushes to the distribution configuration to all of the chosen edge locations.
* If users tries to access data at an edge location and the content is not available it called a "cache missing" and the edge location will check the regional edge location for the content. If content is not in regional cahce a process called "Orgin fetch" is used to obtain the content from the Origin. Then the content is cached is at the regional and local edge location.
* A cache hit is when the content is available at the edge location right away.
* **Cache hits improve performance by reducing calls to the Origin.**
* Integrates with ACM for SSL certificate management
* **Cloudfront caching is used for downloads only and uploads go direct to origins.**
* Cache behaviors are configurations within the distributions. Sit in the middle between Origins and distributions.
  * default(*)
  * Can configure behaviors with path patterns such as img/* that direct traffic instead of the default action
 
TTL Invalidations
* Determines how long content is stored in the edge locations
* How do remove content before the TTL expires?
* Content can expire but is not immediately removed and become stale? The edge locations request content from the origin and if the origin sends a 304 not modified the content is then marked as current and sent to viewers from the edge location. Is the TTL updated?
* If the origin has new content then a 200 ok is sent along with the new data.
* Default TTL is 24 hours (behaviors) validity period
* Minimum and Maximum TTL values are set on a per object level
* **Headers**
* Cache-control max-age in seconds -
* Cache-control s-maxage in seconds -
* Expires - date and time
* AWS recommends using Cache-control max-age over Exprires. If both are configured only Cache-control max-age is used.
* Custom origin these headers must be injected by the application
* S3 as the origin, the headers can be set using object metadata
* Cache invalidations
  * Performed on a distribution
  * Applies to all edge location and can take a long time
  * /imgs/car.pic - invalidates a single object
  * /imgs/* - invalidates all objects under the directory
  * /* - invalidates all cached objects in the distribution
  * **Use versioned file names to avoid frequent invalidations and saves money**
    *  **/imgs/car_v1.jpg, car_v2.jpg**
* Cache-Control or Expires headers from the Origin control how long the browser caches the data before sending the request to CloudFront

# CloudFront SSL
* **SSL supported by default with *cloudfront.net cert.**
* Must add a custom SSL certificate when using custom domains even if you don't use HTTPS.
* **SSL certificates between the Viewer and CloudFront and between CloudFront and the Origin(EC2 mainly) must be valid *public* and intermediate certificates.**
    * ALB can use publicly signed certificates. ACM or external generated cert.
    * The DNS name on the Origin must match the distriution name
* Use a dedicated IP on the distribution to support older (NON SNI) browsers and new browsers.
    * This cost extra.
* Cannot use self signed certificates Public trusted signed certificates only.

# ACM
* Certificates created by ACM can be automatically renewed
* Certificates can be imported into ACM but you are responsible for renewals
* ACM certficated can only be deployed to supported services.
  * List of supported services
  * CloudFront
  * ALBs (not EC2)
* ACM is a regional service
* Certs created in one region cannot be used by a service in another region.
* **ACM certs for CloudFront should be created in us-east-1**
