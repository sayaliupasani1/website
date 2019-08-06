+++
title = "Projects"
slug = "projects"
thumbnail = "images/webpage.png"
description = "projects"
+++

#### Deploy static website with CI/CD

{{% portfolio image="/images/website-home.png" alt="Deploy website with Terraform and TravisCI" %}}

#### Deploy website with Terraform and TravisCI

This project includes Terraform code to deploy a static website on AWS s3. It also incorporates automated builds, tests and deployments with TravisCI.

###### Highlights:

- The website is deployed on AWS s3 and it uses Cloudfront distribution's caching and SSL features.
- With TravisCI, all you need to do is a git push, which initiates automatic build and deployment.
- For more details on the process, check my blog [link](https://sayaliupasani.com/posts/website-terraform/).

Github link: [Website](https://github.com/sayaliupasani1/website)
{{% /portfolio %}}

#### Endpoint Health Checker

{{% portfolio image="/images/endpoint.png" alt="Endpoint Health Checker" %}}

#### Endpoint Health Checker

This is a python based application that verifies the status of the user-specified URL.

###### Highlights:

- This application is docker containerized and it runs on two containers - one is a simple alpine container to serve the application and second is an nginx container to listen for the incoming requests.
- Due to the use of nginx, the application has capabilites to run multiple python app containers and nginx can load balance between them.
- I have also implemented this with Ansible playbook.

Github link: [Endpoint Health checker](https://github.com/sayaliupasani1/url_status_docker)
{{% /portfolio %}}

#### News Bulletin Agrregator

{{% portfolio image="/images/newsbulletin.png" alt="News Bulletin Aggregator" %}}

#### News Bulletin Aggregator

This is a python application to scrape relevant news updates from multiple sites and display it in an aggregated way.

Github link: [News Bulletin Aggregator](https://github.com/sayaliupasani1/content_aggregator)
{{% /portfolio %}}