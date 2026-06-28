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
