# Day 1: Introduction to IaC & Terraform (AWS Context)

## What is Infrastructure as Code (IaC)?

The practice of managing and provisioning infrastructure through machine-readable definition files, rather than manual hardware configuration or interactive tools. Think of it as writing code to build and manage your servers, networks, databases, etc.

**Benefits of IaC:**

* **Consistency:** Ensures your infrastructure is deployed in the same way every time, reducing configuration drift.
* **Automation:** Automates the provisioning and management process, saving time and reducing manual errors.
* **Version Control:** Infrastructure code can be versioned using tools like Git, allowing you to track changes, rollback, and collaborate.
* **Repeatability:** Easily create multiple identical environments (e.g., development, staging, production).
* **Cost Reduction:** Optimizes resource utilization and reduces the need for manual intervention.

## Why Terraform?

* **Provider-Based Architecture:** Supports a wide range of cloud providers (AWS, Azure, GCP, etc.) and other services through plugins called providers.
* **Declarative Language (HCL - HashiCorp Configuration Language):** You describe the desired state of your infrastructure, and Terraform figures out how to achieve it. You don't need to write imperative steps.
* **State Management:** Terraform keeps track of the current state of your infrastructure, allowing it to plan and apply changes effectively.
* **Execution Plans:** Before making any changes, Terraform generates an execution plan showing you exactly what will be created, modified, or destroyed. This provides a crucial safety net.
* **Large and Active Community:** Benefit from extensive documentation, tutorials, and community support.
* **Open Source:** Freely available and allows for community contributions.

## Install Terraform

1.  Follow the official Terraform documentation for your operating system: [https://developer.hashicorp.com/terraform/downloads](https://developer.hashicorp.com/terraform/downloads)
2.  Verify the installation by running `terraform --version` in your terminal.

## Configure AWS Provider

1.  Understand the concept of providers in Terraform.
2.  Learn how to configure the AWS provider in your `main.tf` file, typically involving:
    * Specifying the `provider` block with the `aws` name.
    * Defining the `region` where you want to create resources.
    * Understanding different ways to provide AWS credentials (environment variables, AWS CLI configuration, IAM roles - for now, focus on environment variables or AWS CLI).

    ```terraform
    terraform {
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 5.0" # Replace with the latest recommended version
        }
      }
    }

    provider "aws" {
      region = "your-aws-region" # Replace with your desired AWS region (e.g., us-east-1)
      # credentials can be configured via environment variables (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)
      # or your AWS CLI configuration
    }
    ```

## Create basic `main.tf` with an S3 bucket

1.  Learn about Terraform resource blocks.
2.  Understand the basic structure of a resource block (e.g., `resource "aws_s3_bucket" "my_first_bucket" { ... }`).
3.  Explore basic arguments for the `aws_s3_bucket` resource (e.g., `bucket`, `acl`).

    ```terraform
    resource "aws_s3_bucket" "my_first_bucket" {
      bucket = "your-unique-bucket-name" # Replace with a globally unique bucket name
      acl    = "private"
    }
    ```

## Basic Terraform Commands (to run in your terminal):

* `terraform init`: Initializes the Terraform working directory and downloads the AWS provider.
* `terraform plan`: Generates an execution plan, showing what Terraform will do.
* `terraform apply`: Applies the changes defined in your configuration, creating the S3 bucket. Type `yes` when prompted to confirm.
* `terraform destroy`: Deletes the resources created by Terraform (important for cleaning up!). Type `yes` when prompted to confirm.

**Remember to replace placeholders like `"your-aws-region"` and `"your-unique-bucket-name"` with your actual values.**