# Day 2: AWS Provider & Basic EC2 Instance

## Recap from Day 1

* We learned about Infrastructure as Code (IaC) and its benefits.
* We understood why Terraform is a popular IaC tool.
* We installed Terraform and configured the basic AWS provider block in `main.tf`.
* We created a simple S3 bucket using Terraform.

## Understanding AWS Provider Configuration (Deep Dive)

On Day 1, we touched upon the basic configuration of the AWS provider. Let's delve deeper into some important aspects:

* **`region`:** This argument specifies the AWS region where your resources will be created. It's crucial to choose the region that best suits your needs (latency, cost, availability). You can set this directly in the `provider` block or use an environment variable (`AWS_REGION` or `AWS_DEFAULT_REGION`).

* **Credentials:** Terraform needs permissions to interact with your AWS account. Here are common ways to provide credentials (choose the method that best fits your security posture and environment):
    * **Environment Variables:** Set `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as environment variables. This is simple for local testing but generally not recommended for production due to security risks.
    * **AWS CLI Configuration:** If you have configured your AWS credentials using the AWS Command Line Interface (`aws configure`), the Terraform AWS provider can often pick these up automatically.
    * **IAM Roles for EC2 Instances:** When running Terraform from an EC2 instance, you can assign an IAM role to the instance with the necessary permissions. Terraform will automatically use these credentials.
    * **IAM Roles for Terraform Cloud/Enterprise:** When using Terraform Cloud or Enterprise, you can configure IAM roles that these services will assume.
    * **`profile`:** If you have multiple named profiles configured in your AWS CLI configuration files (`~/.aws/credentials`), you can specify the profile to use in the `provider` block:

        ```terraform
        provider "aws" {
          region = "us-east-1"
          profile = "your-aws-profile-name"
        }
        ```

* **`assume_role` (Advanced):** This allows Terraform to assume an IAM role in your AWS account before making API calls. This is a best practice for granting least privilege.

    ```terraform
    provider "aws" {
      region = "us-east-1"
      assume_role {
        role_arn = "arn:aws:iam::123456789012:role/TerraformExecutionRole"
      }
    }
    ```

* **Provider Versioning:** It's good practice to pin the version of the AWS provider you are using in the `required_providers` block in your `terraform` configuration. This ensures that your configuration behaves predictably.

    ```terraform
    terraform {
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 5.0" # Use a specific version or version constraint
        }
      }
    }
    ```

## Creating a Simple EC2 Instance with Terraform - Workflow

```mermaid
graph TD
    A[Start] --> B{Define 'aws_instance' Resource (e.g., in ec2.tf)};
    B --> C{Specify 'ami' (Ubuntu AMI ID)};
    C --> D{Specify 'instance_type' (e.g., t2.micro)};
    D --> E{Specify 'key_name' (Existing EC2 Key Pair)};
    E --> F{Specify 'subnet_id' (within a VPC)};
    F --> G{Reference 'vpc_security_group_ids' (Security Group Resource)};
    G --> H{Define 'aws_security_group' Resource (if not existing)};
    H --> I{Configure Security Group 'ingress' Rules (e.g., SSH)};
    I --> J{Configure Security Group 'egress' Rules (e.g., All Outbound)};
    J --> K{Run 'terraform init'};
    K -- Success --> L{Run 'terraform plan'};
    L --> M{Review Plan Output (Check EC2 & SG Creation)};
    M -- Looks Good --> N{Run 'terraform apply'};
    N -- Success --> O[EC2 Instance & Security Group Created in AWS];
    N -- Failure --> P[Check Terraform Output & AWS Logs];
    O --> Q[End of EC2 Creation];
    P --> Q;



```hcl

resource "aws_instance" "my_first_ec2" {
  ami           = "ami-xxxxxxxxxxxxxxxxx" # Replace with a valid AMI ID for your chosen region
  instance_type = "t2.micro"             # Choose an instance type
  key_name      = "your-key-pair-name"    # Replace with the name of your EC2 key pair
  subnet_id     = "subnet-yyyyyyyyyyyyyyy" # Replace with your desired subnet ID

  tags = {
    Name = "MyFirstTerraformEC2"
  }

  vpc_security_group_ids = [aws_security_group.basic_ssh.id] # Reference to the security group created by Terraform
}

resource "aws_security_group" "basic_ssh" {
  name_prefix = "basic-ssh-"
  vpc_id      = "your-default-vpc-id" # Replace with your default VPC ID

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Adjust as needed (e.g., your specific IP address)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "basic-ssh-security-group"
  }
}

```


# EC2 Instance Creation: Manual vs Terraform

---

## 🧭 Overview

We will explore two ways to create an EC2 instance:

1. **Manual Method** via AWS Console
2. **Infrastructure as Code** using Terraform

---

## 📌 1. Manual EC2 Instance Creation (AWS Console)

```txt
+-------------------+
| Login to AWS      |
+-------------------+
         |
         v
+------------------------+
| Go to EC2 Dashboard    |
+------------------------+
         |
         v
+-------------------------------+
| Click "Launch Instance"       |
+-------------------------------+
         |
         v
+----------------------------------------+
| Choose AMI (Amazon Machine Image)      |
| e.g., Amazon Linux 2                   |
+----------------------------------------+
         |
         v
+-------------------------------+
| Choose Instance Type          |
| e.g., t2.micro (Free Tier)    |
+-------------------------------+
         |
         v
+-------------------------------+
| Configure Network (VPC, etc.) |
+-------------------------------+
         |
         v
+-----------------------------+
| Add Storage (8GB default)  |
+-----------------------------+
         |
         v
+------------------------------+
| Add Tags (e.g., Name=Demo)   |
+------------------------------+
         |
         v
+------------------------------+
| Configure Security Group     |
| Allow SSH (port 22)          |
+------------------------------+
         |
         v
+------------------------------+
| Review and Launch            |
+------------------------------+
         |
         v
+------------------------------+
| Choose/Create Key Pair       |
+------------------------------+
         |
         v
+------------------------------+
| Instance Launched! 🎉        |
+------------------------------+
