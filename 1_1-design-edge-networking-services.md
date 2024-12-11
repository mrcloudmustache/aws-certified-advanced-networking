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
* Cache hits improve performance by reducing calls to the Origin.
* Integrates with ACM for SSL certificate management
* **Cloudfront caching is used for downloads only and uploads go direct to origins.**
* Cache behaviors are configurations within the distributions. Sit in the middle between Origins and distributions.
  * default(*)
  * Can configure behaviours with path paterrns such as img/* that direct traffic instead of the default action
  
