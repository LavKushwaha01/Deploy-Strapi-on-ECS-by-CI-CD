# Deploy Strapi on AWS ECS using Terraform & GitHub Actions (CI/CD)
---

Loom video: https://www.loom.com/share/53b1e687eab843429b164c558b96993a


This repository demonstrates how to containerize a Strapi application and deploy it on AWS ECS (Fargate) using Terraform for Infrastructure as Code and GitHub Actions for CI/CD automation.
The project covers real-world DevOps practices including IAM configuration, ALB setup, Fargate Spot, CloudWatch logging & dashboards, and environment management.
---

 ## Project Overview

- The goal of this project is to:

- Build and containerize a Strapi application using Docker

- Provision AWS infrastructure using Terraform

- Deploy the containerized application to AWS ECS (Fargate)

- Automate deployment using GitHub Actions (CI/CD)

- Configure CloudWatch Logs & Dashboards for monitoring

- Expose the application using an Application Load Balancer (ALB)

- Optimize cost using Fargate Spot

- Secure the application using environment variables and secrets

---

## Architecture
```bash
Developer (GitHub)
        |
        |  Push code
        v
GitHub Actions (CI/CD)
        |
        |  Terraform Apply
        v
AWS Infrastructure
  ├── Application Load Balancer (ALB)
  │        └── ECS Service (Fargate / Fargate Spot)
  │               └── Strapi Container
  ├── ECS Cluster
  ├── RDS (PostgreSQL)
  ├── VPC + Subnets + Security Groups
  └── CloudWatch Logs + CloudWatch Dashboard
```
---
## Tech Stack

- Strapi – Headless CMS

- Docker – Containerization

- AWS ECS (Fargate) – Container orchestration

- AWS RDS (PostgreSQL) – Database

- Terraform – Infrastructure as Code

- GitHub Actions – CI/CD pipeline

- AWS IAM – Access management

- CloudWatch Logs & Dashboard – Logging & Monitoring

- Application Load Balancer (ALB) – Public access to Strapi

---

##  Repository Structure
```bash
.
├── terraform/
│   ├── ecs.tf           # ECS Cluster, Task Definition, Service (Fargate + Spot)
│   ├── alb.tf           # Application Load Balancer & Target Groups
│   ├── rds.tf           # PostgreSQL RDS instance
│   ├── iam.tf           # ECS Task Execution Role & IAM policies
│   ├── security.tf     # Security Groups
│   ├── cloudwatch.tf   # CloudWatch Log Group & Dashboard
│   ├── variables.tf    # Input variables
│   ├── outputs.tf      # Outputs
│   └── main.tf
│
├── Dockerfile           # Multi-stage Dockerfile for Strapi
├── .github/workflows/
│   ├── cd-deploy.yml   # GitHub Actions workflow for Terraform deploy
│   └── cd-destroy.yml  # GitHub Actions workflow for Terraform destroy (manual)
└── README.md
```

# How CI/CD Works

## 1. Code Push / Manual Trigger

GitHub Actions workflow is triggered using workflow_dispatch (manual trigger) or on push (if configured).

## 2. Build & Push Docker Image

GitHub Actions builds the Strapi Docker image.

The image is tagged with the commit SHA.

The image is pushed to the container registry (ECR/Docker Hub as configured).

## 3. Infrastructure Provisioning (Terraform)

Terraform provisions:

ECS Cluster

ECS Task Definition

ECS Service (Fargate / Fargate Spot)

Application Load Balancer (ALB)

RDS PostgreSQL

VPC, Subnets, Security Groups

IAM Execution Role

CloudWatch Log Groups

CloudWatch Dashboard

## 4. Deployment

ECS Fargate pulls the latest Docker image.

Strapi runs inside ECS tasks.

ALB routes traffic to the Strapi service.

Logs are streamed to CloudWatch.

## 5. Destroy (Optional)

A separate workflow (cd-destroy.yml) can destroy all infrastructure using Terraform.

---

## CloudWatch Logs & Dashboard
- CloudWatch Logs

Each ECS task sends application logs to CloudWatch Log Groups.

Helps in:

Debugging application issues

Viewing container logs

Monitoring errors and crashes

- CloudWatch Dashboard

A custom CloudWatch Dashboard is created to monitor:

ECS CPU utilization

ECS Memory utilization

ALB request count

ALB target response time

RDS CPU usage

This gives a single-pane view of application health and performance.

---

## Application Load Balancer (ALB)

The ALB exposes Strapi to the internet.

Routes HTTP traffic to ECS tasks.

Handles:

Load balancing

Health checks

Public endpoint for Strapi

ALB target group is attached to the ECS service.

---

## Fargate Spot (Cost Optimization)

ECS service is configured to use Fargate Spot capacity provider.

Benefits:

Lower cost compared to normal Fargate

Suitable for non-production or learning environments

Note:

Spot tasks can be interrupted, so this setup is ideal for dev/test workloads.

---

## Security & Environment Management

Secrets and environment variables are injected into ECS Task Definitions:

Database credentials

Strapi app keys

IAM roles are scoped with minimum required permissions.

Security groups restrict access between:

ALB → ECS

ECS → RDS

---

## Key Changes Made in This Project

Compared to a basic ECS deployment, the following enhancements were implemented:

-  Migrated deployment from EC2 to ECS Fargate

-  Added Application Load Balancer (ALB) for public access

-  Configured CloudWatch Log Groups for ECS container logs

-  Created a CloudWatch Dashboard for monitoring ECS, ALB, and RDS

-  Enabled Fargate Spot for cost optimization

-  Automated full CI/CD using GitHub Actions + Terraform

-  Implemented secure IAM roles for ECS task execution

-  Structured Terraform modules for better readability and maintainability