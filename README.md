# website
This repo includes hugo template for my personal website. Its hosted on AWS s3 using Terraform.

![Uptime Robot status](https://img.shields.io/uptimerobot/status/m783213923-5d3a1065e544e7f9afadf477)
![Travis (.com)](https://img.shields.io/travis/com/sayaliupasani1/website)

### Basic idea of the repo:

The repo essentially consists of following files:

- website theme and content
- terraform: the 'terraform' directory consists of files that are used to deploy this website on AWS S3 using terraform.
- .travis.yml: Consists of my travis code, that triggers an automatic build and deploy of changes on the origin website for git push on the repo's master branch

This repo can deploy a static website on AWS S3 using terraform and have TravisCI build and deploy each change pushed to git.

---
### Deployment details:

###### Under terraform directory:

- [`main.tf`](/terraform/main.tf):Includes the main code to create an S3 bucket with static website enabled, local-exec to upload your files, configure AWS cloudfront distribution for caching and SSL, configure AWS Route53 to push A records for your domain with Cloudfront as an alias target.
- [`variables.tf`](/terraform/variables.tf): Defines the variables that are used in main.tf. If you define variables for your aws access and secret key, you need to define the values in separate file, which should not be pushed to remote version control systems.
- aws_envs.sh: To set AWS access and secret key as environment variables for TravisCI builds and deploy.
- [`remote_state`](/terraform/remote_state/): This directory includes files to configure AWS s3 backend resource that will be storing your terraform state (Required to preserve state when deployments are done from different systems - must for TravisCI)and AWS DynamoDB for securing lock on terraform state that will ensure not more than one developer deploying changes.

###### How to deploy?

In terraform directory, issue following commands:

1) Initialize terraform
`terraform init`

2) Plan the changes
`terraform plan`
This will list the changes that will be taken by terraform when you perform next apply
Since we are using remote terraform state, it will pull the state from remote s3 backend in order to understand existing state and plan changes in accordance.

3) Apply changes
`terraform apply`

> Note: Cloudfront distribution creation/update takes a long time.

> Tainting S3 resource: Terraform itself won't recognize any changes to website content you do locally and hence it won't upload the new files on subsequent apply. 
> You need to manually taint 'upload_files_s3' resource before apply as follows:

`terraform taint null_resource.upload_files_s3`

For new content to propagate immediately, invalidate cloudfront cache as follows:

```
aws cloudfront create-invalidation --distribution-id <CLOUDFRONT_DIST ID> --paths "/*"
```

###### Using Travis:

1) Login to your Travis account and add the repo that you want travis to monitor
2) Push the .travis.yml file to the root of your repo
3) You need to add your AWS access key and secret key as enviroment variables in your Travis
4)Any subsequent push to your git repo will trigger TravisCI's build and deployment.

---

### Further plans:

This repo is work in progress and below are some ongoing plans:

- [x] To upload the content of my static website, I am currently using terraform's local-exec.
> It works great for first deploy, but any subsequent changes to content is not recognized by terraform.
Hence, I need to taint this local-exec resource before terraform apply. I have automated this with TravisCI.

- [x] On making changes to content, I need to perform a manual cloudfront distribution cache invalidation.
> Again, automated this with `awscli` on TravisCI.

- [ ] I plan to research on AWS lambda to achieve this using terraform itself.

### Credits

Thanks to [naro143](https://github.com/naro143/hugo-coder-portfolio) for the awesome hugo theme (hugo-coder-portfolio).