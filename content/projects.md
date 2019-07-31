+++
title = "Projects"
slug = "projects"
thumbnail = "images/webpage.png"
description = "projects"
+++

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