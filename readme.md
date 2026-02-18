#  Deploy Strapi on AWS ECS using Terraform & GitHub Actions (CI/CD)

Loom video: https://www.loom.com/share/925966f8844443f49a19aa3984fe1bca

This repository demonstrates how to containerize a Strapi application and deploy it on AWS ECS (Fargate) using Terraform for Infrastructure as Code and GitHub Actions for CI/CD automation. The project covers real-world DevOps practices including IAM configuration, container orchestration, logging, and environment management.
--- 

# Project Overview

The goal of this project is to:

Build and containerize a Strapi application using Docker

Provision AWS infrastructure using Terraform

Deploy the containerized application to AWS ECS (Fargate)

Automate deployment using GitHub Actions (CI/CD)

Configure CloudWatch logging for observability

Secure the application using environment variables and secrets

# Architecture

Developer (GitHub)
        |
        |  Push code
        v
GitHub Actions (CI/CD)
        |
        |  Terraform Apply
        v
AWS Infrastructure
  ├── ECS Cluster (Fargate)
  │     └── Strapi Container
  ├── RDS (PostgreSQL)
  ├── VPC + Subnets + Security Groups
  └── CloudWatch Logs

# Tech Stack

Strapi – Headless CMS

Docker – Containerization

AWS ECS (Fargate) – Container orchestration

AWS RDS (PostgreSQL) – Database

Terraform – Infrastructure as Code

GitHub Actions – CI/CD pipeline

AWS IAM – Access management

CloudWatch Logs – Logging & monitoring

# Repository Structure
.
├── terraform/
│   ├── ecs.tf           # ECS Cluster, Task Definition, Service
│   ├── rds.tf           # PostgreSQL RDS instance
│   ├── iam.tf           # ECS Task Execution Role
│   ├── security.tf     # Security Groups
│   ├── variables.tf    # Input variables
│   ├── outputs.tf      # Outputs
│   └── main.tf
│
├── Dockerfile           # Multi-stage Dockerfile for Strapi
├── .github/workflows/
│   ├── cd-deploy.yml   # GitHub Actions workflow for Terraform deploy
│   └── cd-destroy.yml  # GitHub Actions workflow for Terraform destroy (manual)
└── README.md

# How CI/CD Works

Code Push / Manual Trigger

GitHub Actions workflow is triggered manually (workflow_dispatch).

Infrastructure Provisioning

Terraform provisions:

ECS Cluster

ECS Task Definition

ECS Service

RDS PostgreSQL

Security Groups

IAM Execution Role

Deployment

ECS Fargate pulls the Docker image from Docker Hub.

Strapi runs inside the ECS task.

Logs are sent to CloudWatch.

Destroy (Optional)

A separate workflow can destroy infrastructure (if Terraform state is available).
