# AWS DevOps CI/CD Pipeline using Terraform, GitHub Actions, Docker, Amazon ECS Fargate & RDS #

## Project Overview ##

This project demonstrates a complete end-to-end DevOps workflow by deploying a containerized Python Flask web application on AWS using modern DevOps tools and cloud services. The application is a simple DevOps Portfolio website that displays a landing page showcasing the technologies used in the deployment, including Docker, GitHub Actions, Terraform, Amazon ECS, Amazon ECR, Amazon RDS, CloudWatch, IAM, VPC, and Application Load Balancer.

The Flask application is packaged into a Docker image, which contains the application code, Python runtime, dependencies, and web server configuration required to run the application consistently across environments.

When the Docker image is started, it creates a Docker container, which is the running instance of the application. This container serves the Flask web application on port 5000.

The project uses GitHub Actions to automate the CI/CD pipeline. Whenever code is pushed to the main branch, the workflow automatically builds a new Docker image, authenticates with Amazon Elastic Container Registry (ECR), and pushes the latest image to the private ECR repository.

Amazon ECS Fargate then pulls the latest Docker image from ECR and deploys it as a container without requiring any EC2 instances. The application is exposed to users through an Application Load Balancer (ALB), while Amazon RDS MySQL provides the backend relational database.

All AWS infrastructure—including networking, security, load balancing, ECS, IAM roles, and the database—is provisioned using Terraform, making the entire deployment reproducible and version-controlled.

This project demonstrates practical experience with Infrastructure as Code (IaC), containerization, CI/CD automation, AWS networking, managed container services, and production-style application deployment.



## Tech Stack

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)
![Amazon ECS](https://img.shields.io/badge/Amazon_ECS-FF9900?style=for-the-badge&logo=amazonecs&logoColor=white)
![Amazon ECR](https://img.shields.io/badge/Amazon_ECR-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![Amazon RDS](https://img.shields.io/badge/Amazon_RDS-527FFF?style=for-the-badge&logo=amazonrds&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

- **Cloud Platform:** Amazon Web Services (AWS)
- **Infrastructure as Code:** Terraform
- **Version Control:** Git, GitHub
- **CI/CD:** GitHub Actions
- **Containerization:** Docker
- **Container Registry:** Amazon Elastic Container Registry (ECR)
- **Container Orchestration:** Amazon Elastic Container Service (ECS Fargate)
- **Networking:** Amazon VPC, Public & Private Subnets, Internet Gateway, NAT Gateway, Route Tables
- **Load Balancing:** Application Load Balancer (ALB), Target Group
- **Database:** Amazon RDS (MySQL)
- **Security:** IAM, Security Groups
- **Monitoring:** Amazon CloudWatch
- **Application:** Flask

## Features

- Infrastructure provisioned using Terraform
- Custom AWS VPC with public and private subnets
- Dockerized Flask web application
- Automated CI/CD using GitHub Actions
- Docker images stored in Amazon ECR
- Container deployment on Amazon ECS Fargate
- Internet-facing Application Load Balancer
- Health checks using Target Groups
- Amazon RDS MySQL database
- IAM Roles with least privilege
- CloudWatch monitoring
- Infrastructure separated into modular Terraform files


# Project Walkthrough

## Step 1 – Build and Run the Application Locally using Docker

Before deploying to AWS, the application was tested locally using Docker Compose.

The following command was used to build the Docker image and start all required containers.

```bash
docker compose up -d --build
```

This performs the following tasks:

- Builds the Flask application Docker image using the Dockerfile.
- Pulls the MySQL 8.4 image from Docker Hub.
- Creates the application and database containers.
- Starts both containers in detached mode.
- Exposes the Flask application on port **5000**.

After the containers started successfully, the following commands were used to verify the deployment.

```bash
docker ps
docker images
```


<img width="1917" height="782" alt="Screenshot from 2026-06-28 19-14-09" src="https://github.com/user-attachments/assets/a07f6e7c-3707-4c2b-a8d4-0ab9bbc86651" />

## Step 2 – Provision AWS Infrastructure using Terraform

Before configuring the CI/CD pipeline, the required AWS infrastructure was provisioned using **Terraform**.

Terraform was used as the Infrastructure as Code (IaC) tool to automate the creation of all AWS resources required to host the application. This ensured that the infrastructure was reproducible, version-controlled, and could be deployed consistently without manual configuration through the AWS Console.

The following Terraform commands were executed to provision the infrastructure:

```bash
terraform init
terraform plan
terraform apply
```

The following AWS resources were created:

- Amazon VPC
- Public & Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- IAM Roles
- Amazon Elastic Container Registry (ECR)
- Amazon ECS Cluster
- Amazon ECS Task Definition
- Amazon ECS Service
- Application Load Balancer (ALB)
- Target Group
- Amazon RDS (MySQL)
- Amazon CloudWatch Log Group

Creating the infrastructure before configuring the CI/CD pipeline was essential because GitHub Actions requires an existing Amazon ECR repository to push Docker images and an existing Amazon ECS service to deploy new application versions.

## Step 3 – Continuous Integration using GitHub Actions

After verifying that the application worked locally, the source code was pushed to the GitHub repository.

A GitHub Actions workflow was configured to automatically build and publish the Docker image whenever changes are pushed to the **main** branch.

The workflow performs the following tasks:

- Checks out the latest source code.
- Configures AWS credentials using GitHub Secrets.
- Authenticates with Amazon Elastic Container Registry (ECR).
- Builds the Docker image.
- Tags the image.
- Pushes the latest image to the private Amazon ECR repository.

This eliminates the need to manually build and upload Docker images, providing an automated Continuous Integration (CI) pipeline.
<img width="1866" height="691" alt="Screenshot from 2026-06-28 19-22-46" src="https://github.com/user-attachments/assets/f34dcdc6-956f-4e54-b101-bdd7a723b43d" />


## Step 4 – Store the Docker Image in Amazon Elastic Container Registry (ECR)

Once the GitHub Actions workflow completed successfully, the Docker image was automatically pushed to a private Amazon Elastic Container Registry (ECR) repository.

Amazon ECR serves as the central image repository for the application. Instead of building the image directly on the ECS cluster, ECS simply pulls the latest image from ECR whenever a new deployment is performed.

This approach provides a secure and scalable way to store, manage, and version container images.

The repository also has image scanning enabled, allowing vulnerabilities in the Docker image to be detected before deployment.

The following screenshots show the private ECR repository, the uploaded Docker image, and the vulnerability scan results.

<img width="1907" height="445" alt="Screenshot from 2026-06-28 10-51-35" src="https://github.com/user-attachments/assets/39df0fff-a902-445f-a6f1-117b21e13101" />

The private Amazon ECR repository stores the Docker images used for deployment.


<img width="1905" height="738" alt="Screenshot from 2026-06-28 10-52-01" src="https://github.com/user-attachments/assets/287b7496-c33c-4f85-9aff-949e6f42d533" />


The latest Docker image has been successfully pushed to Amazon ECR by the GitHub Actions workflow.



## Step 5 – Deploy the Amazon RDS MySQL Database

The application uses **Amazon RDS MySQL** as its managed relational database.

Terraform provisioned the RDS instance inside the private subnets of the VPC, ensuring that the database is not publicly accessible from the internet. Only the ECS application can connect to the database through the configured security groups.

Using Amazon RDS removes the need to install, configure, and manage MySQL on a virtual machine while providing automated backups, monitoring, and high availability features.

The screenshot below shows the successfully deployed RDS MySQL instance.

<img width="1872" height="911" alt="Screenshot from 2026-06-28 10-54-44" src="https://github.com/user-attachments/assets/59577936-fc88-4711-89d1-522d022eb7ea" />


## Step 6 – Create the Amazon ECS Cluster

After provisioning the networking and database infrastructure, an **Amazon ECS (Elastic Container Service) Cluster** was created using Terraform.

The ECS Cluster acts as the logical environment that hosts the containerized application. This project uses the **AWS Fargate** launch type, allowing containers to run without managing or provisioning EC2 instances.

Using Fargate eliminates server management tasks such as operating system updates, capacity planning, and instance maintenance, enabling the application to run on fully managed infrastructure.

The screenshot below shows the ECS Cluster with the deployed service and running task.

<img width="1905" height="738" alt="Screenshot from 2026-06-28 10-52-26" src="https://github.com/user-attachments/assets/08a40cbc-2c16-4a75-ac32-f992cd9ff290" />


## Step 7 – Create the ECS Task Definition

The **Amazon ECS Task Definition** acts as a blueprint for running the containerized application on AWS Fargate.

It defines how the application should run, including the Docker image stored in Amazon ECR, CPU and memory allocation, networking mode, IAM roles, container port, and CloudWatch logging configuration.

Whenever a new version of the application is deployed, Amazon ECS uses this task definition to launch the container.

The screenshot below shows the task definition created for the Flask application.

<img width="1872" height="911" alt="Screenshot from 2026-06-28 10-53-36" src="https://github.com/user-attachments/assets/4954c901-3f6c-458a-bfcb-d11cb750c95e" />



## Step 8 – Deploy the Application using Amazon ECS Service

After the task definition was created, an **Amazon ECS Service** was deployed using the AWS Fargate launch type.

The ECS Service continuously maintains the desired number of running tasks. If a task stops unexpectedly, ECS automatically launches a replacement to maintain application availability.

The service pulls the latest Docker image from Amazon ECR, launches the container, and registers it with the Application Load Balancer Target Group. Health checks ensure that only healthy containers receive incoming traffic.

The screenshots below show the ECS Service and the running task after a successful deployment.

<img width="1872" height="911" alt="Screenshot from 2026-06-28 10-53-15" src="https://github.com/user-attachments/assets/3f0f9a24-6f05-4d9b-8366-1330069d259c" />
<img width="1872" height="911" alt="Screenshot from 2026-06-28 10-53-06" src="https://github.com/user-attachments/assets/9e1d70d4-0568-4d0e-be63-5628c61dc529" />


## Step 9 – Configure the Application Load Balancer (ALB)

An **Application Load Balancer (ALB)** was provisioned using Terraform to provide a single public entry point for the application.

The ALB listens for incoming HTTP requests and forwards them to the ECS Service through a Target Group. This enables users to access the application using the ALB DNS name instead of connecting directly to the container.

The Target Group continuously performs health checks on the running ECS task. Only healthy containers receive incoming traffic, improving application availability and reliability.

The screenshots below show the Application Load Balancer and the healthy Target Group after deployment.

<img width="1872" height="911" alt="Screenshot from 2026-06-28 10-54-19" src="https://github.com/user-attachments/assets/f9c5b5af-ec52-455d-8a70-0e5413385f4d" />

*Application Load Balancer configured to receive incoming HTTP traffic and forward requests to the ECS Service.*


<img width="1872" height="911" alt="Screenshot from 2026-06-28 10-54-04" src="https://github.com/user-attachments/assets/859b46ff-b950-439c-b588-8054dd28571c" />

*The Target Group performs health checks and confirms that the ECS task is healthy and ready to receive traffic.*


## Step 10 – Application Successfully Deployed

The Flask application was successfully deployed on **Amazon ECS Fargate** and is publicly accessible through the **Application Load Balancer (ALB)**.

The successful deployment confirms that the complete CI/CD pipeline, Docker containerization, Terraform infrastructure provisioning, and AWS services are working together to deliver the application.

<img width="1918" height="989" alt="Screenshot from 2026-06-28 10-49-58" src="https://github.com/user-attachments/assets/e369bc28-67fd-46c0-935c-5fdb13b1dffe" />


