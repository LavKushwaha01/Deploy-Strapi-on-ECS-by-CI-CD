# Automated CI/CD Deployment to AWS ECS Using GitHub Actions, ECR, Terraform, and CodeDeploy (Blue/Green)

---

Loom Video: https://www.loom.com/share/b6114941bbb54499b51f9ff5ea166b78

---

This repository demonstrates how to containerize a Strapi application and deploy it on AWS ECS (Fargate) using Terraform for Infrastructure as Code and GitHub Actions for CI/CD automation.
The project covers real-world DevOps practices including IAM configuration, Application Load Balancer (ALB) setup, Blue/Green deployments with AWS CodeDeploy, Fargate Spot for cost optimization, CloudWatch logging & dashboards, and environment management.

---

##  Project Overview

#### The goal of this project is to:

- Build and containerize a Strapi application using Docker

- Push container images to Amazon ECR

- Provision AWS infrastructure using Terraform

- Deploy the containerized application to AWS ECS (Fargate)

- Implement Blue/Green deployment strategy using AWS CodeDeploy for zero-downtime releases

- Automate deployments using GitHub Actions (CI/CD)

- Configure CloudWatch Logs & Dashboards for monitoring

- Expose the application using an Application Load Balancer (ALB)

- Optimize cost using Fargate Spot

- Secure the application using environment variables and secrets

##  Architecture
```bash
Developer (GitHub)
        |
        |  Push code / Manual trigger
        v
GitHub Actions (CI/CD)
        |
        |  Build Docker Image & Push to ECR
        |  Terraform Apply
        v
AWS Infrastructure
  ├── Application Load Balancer (ALB)
  │        └── CodeDeploy (Blue/Green)
  │               └── ECS Service (Fargate / Fargate Spot)
  │                       └── Strapi Container
  ├── ECS Cluster
  ├── Amazon ECR (Container Registry)
  ├── RDS (PostgreSQL)
  ├── VPC + Subnets + Security Groups
  └── CloudWatch Logs + CloudWatch Dashboard
  ```
  ----
### Tech Stack

- Strapi – Headless CMS

- Docker – Containerization

- AWS ECS (Fargate / Fargate Spot) – Container orchestration

- Amazon ECR – Container image registry

- AWS RDS (PostgreSQL) – Database

- Terraform – Infrastructure as Code

- GitHub Actions – CI/CD pipeline

- AWS CodeDeploy – Blue/Green deployment strategy

- AWS IAM – Access management

- CloudWatch Logs & Dashboard – Logging & Monitoring

- Application Load Balancer (ALB) – Public access to Strapi

---

## Repository Structure
```bash
.
├── terraform/
│   ├── ecs.tf           # ECS Cluster, Task Definition, Service (Fargate + Spot)
│   ├── alb.tf           # Application Load Balancer & Target Groups (Blue/Green)
│   ├── codedeploy.tf   # CodeDeploy App & Deployment Group (Blue/Green)
│   ├── ecr.tf           # Amazon ECR repository
│   ├── rds.tf           # PostgreSQL RDS instance
│   ├── iam.tf           # ECS Task Execution Role & CodeDeploy IAM Role
│   ├── security.tf     # Security Groups
│   ├── cloudwatch.tf   # CloudWatch Log Group & Dashboard
│   ├── variables.tf    # Input variables
│   ├── outputs.tf      # Outputs (ALB URL, etc.)
│   └── main.tf
│
├── Dockerfile           # Multi-stage Dockerfile for Strapi
├── .github/workflows/
│   ├── cd-deploy.yml   # GitHub Actions workflow for CI/CD deploy
│   └── cd-destroy.yml  # GitHub Actions workflow for infrastructure teardown
└── README.md
```
---
## How CI/CD Works

#### 1. Code Push / Manual Trigger

The GitHub Actions workflow is triggered using workflow_dispatch (manual trigger) or on push (if configured).

#### 2. Build & Push Docker Image

GitHub Actions builds the Strapi Docker image.

The image is tagged with the GitHub commit SHA.

The image is pushed to Amazon ECR.

#### 3.  Infrastructure Provisioning (Terraform)

- Terraform provisions and manages:

ECS Cluster

ECS Task Definition (updated dynamically with new image tag)

ECS Service (Fargate / Fargate Spot)

Application Load Balancer (ALB)

Blue & Green Target Groups

AWS CodeDeploy App & Deployment Group

RDS PostgreSQL

VPC, Subnets, Security Groups

IAM Roles (ECS Execution Role, CodeDeploy Role)

CloudWatch Log Groups

CloudWatch Dashboard

#### 4.  Blue/Green Deployment with CodeDeploy

A new ECS task set (Green) is launched with the updated image.

ALB gradually shifts traffic from Blue → Green.

Health checks validate the new version.

On success, the old version is terminated.

On failure, automatic rollback is triggered.

This ensures zero-downtime deployments.

#### 5.  Application Runtime

ECS Fargate pulls the latest Docker image from ECR.

Strapi runs inside ECS tasks.

ALB routes traffic to healthy ECS tasks.

Application logs are streamed to CloudWatch.

#### 6.  Destroy (Optional)

A separate workflow (cd-destroy.yml) can be used to destroy all infrastructure using Terraform (for cleanup or cost control).

---

## CloudWatch Logs & Dashboard

CloudWatch Logs

Each ECS task sends application logs to CloudWatch Log Groups.
This helps with:

Debugging application issues

Viewing container logs

Monitoring runtime errors and crashes

CloudWatch Dashboard

A custom CloudWatch Dashboard monitors:

ECS CPU utilization

ECS Memory utilization

ALB request count

ALB target response time

RDS CPU usage

This provides a single-pane view of system health and performance.

---

## Application Load Balancer (ALB)

The ALB exposes Strapi to the internet and:

Routes HTTP traffic to ECS tasks

Performs health checks

Works with CodeDeploy to shift traffic during Blue/Green deployments

Provides a stable public endpoint for the application

---

## Fargate Spot (Cost Optimization)

The ECS service is configured to use Fargate Spot as a capacity provider.

Benefits:

Lower cost compared to standard Fargate

Suitable for dev/test and learning environments

- Note: Spot tasks can be interrupted, so this setup is recommended for non-production workloads.

---

## Security & Environment Management

Secrets and environment variables are injected into ECS Task Definitions:

Database credentials

Strapi app keys

IAM roles follow the principle of least privilege.

Security groups restrict access between:

ALB → ECS

ECS → RDS