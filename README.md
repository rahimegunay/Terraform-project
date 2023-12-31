# Terraform project

This project uses a launch template to provision an autoscaling group after using an Application Load Balancer which can scale automatically workloads and deal with the incoming traffic to EC2 instances. 

![Alt text](<static-webserver.drawio (2).png>)

## Requirements
- An AWS account with appropriate permissions.
- Terraform installed on your local machine.
- Vscode
- Git(Version controlling)
- Basic knowledge of Nginx, Docker and AWS services.

## Getting Started
1. Clone this repository to your local machine:

    git clone <repository_url>
    cd terraform-nginx-webserver
2. Update the terraform.tfvars file with your AWS credentials and customize any other variables as needed.
3. Initialize the Terraform workspace
    terraform init

## Terraform Configuration
1. In the Terraform configuration files, define the resources required for your web server infrastructure. Utilize Terraform's declarative language to specify the desired state of your infrastructure.

2. Implement a launch template that defines the EC2 instance specifications, including the Nginx installation and web content configuration.
   
## Auto-Scaling for High Availability
1. Configure an auto-scaling group to automatically adjust the number of EC2 instances based on traffic demand. Define policies for scaling in and out to maintain high availability and efficient resource utilization.

2. Utilize launch templates within the auto-scaling group to ensure consistent configuration across all instances.

## Load Balancing for Traffic Distribution
1. Set up an Application Load Balancer (ALB) using Terraform to evenly distribute incoming traffic across your EC2 instances.

2. Attach the ALB to your auto-scaling group to ensure new instances are automatically registered with the load balancer.

3. Monitor your web server's performance and traffic distribution through the AWS Management Console.

## Docker Deployment with userdata.tpl
1. Enhance your Terraform configuration by creating a userdata.tpl file. This template script will run on each EC2 instance upon launch.

2. Use userdata.tpl to install Docker and deploy your web application containers. You can pull your Docker images and launch containers with the desired configurations.

3. Customize the userdata.tpl script to suit your application's requirements, such as environment variables, secrets, and container orchestration.
   
## Conclusion
Voila!! You have successfully deployed a scalable static web server powered by Nginx using Terraform, auto-scaling, a load balancer, launch templates, and Docker on Ubuntu instances. Your infrastructure is now capable of handling varying workloads, maintaining high availability, distributing traffic efficiently, and deploying and managing Docker containers seamlessly.In order to automate this process, github Actions could be used for CI/CD.

## Note
The resources created in this demo project may incur cost. So please take care to destroy the infrastructure if you don't need it.


