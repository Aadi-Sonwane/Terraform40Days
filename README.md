# 40-Day Hands-On Learning Schedule


### Day 1: Terraform Installation & Basic Commands - Create a Local File

- Understand the basic Terraform workflow: `init`, `plan`, `apply`, `destroy`.
- **Hands-On:**
  - Install Terraform.
  - Create a `main.tf` file with a `local_file` resource.
  - Run the following commands:
    - `terraform init`
    - `terraform plan`
    - `terraform apply`
  - Verify the file creation.
  - Run `terraform destroy` to clean up.

---

### Day 2: AWS Provider - Configure Your Region

- Learn about Terraform Providers and the AWS Provider.
- **Hands-On:**
  - Configure the `aws` provider in your `main.tf`, specifying your desired region.
  - Ensure your AWS credentials are set using either:
    - Environment variables, or
    - `aws configure` via the AWS CLI.

---

### Day 3: AWS S3 Bucket - Create, Upload, Enable Versioning

- Understand the `aws_s3_bucket` and `aws_s3_bucket_versioning` resources.
- **Hands-On:**
  - Define these resources in your `main.tf`.
  - Run `terraform apply` to provision the S3 bucket.
  - Use the AWS CLI or Console to upload a file and verify versioning.
  - Run `terraform destroy` to clean up.

---

### Day 4: Variables - Parameterize Your S3 Bucket Name

- Learn how to define and use input variables in `variables.tf`.
- **Hands-On:**
  - Create a `variables.tf` file with a variable for the bucket name.
  - Update the `aws_s3_bucket` resource to use this variable.
  - Provide a value in `terraform.tfvars` or via `-var` flag on the command line.
  - Apply and verify the setup.

---

### Day 5: Output Values & Data Source - Fetch S3 Bucket ARN

- Understand output values and data sources.
- **Hands-On:**
  - Define an `output` to export the S3 bucket ARN.
  - Use the `aws_s3_bucket` data source to fetch the ARN.
  - Run `terraform apply` and observe the output values in your terminal.



### Day 6: Terraform State - Inspect and Understand Local State

- Learn about the Terraform state file: `terraform.tfstate`.
- **Hands-On:**
  - Apply a configuration to create an S3 bucket.
  - Inspect the `terraform.tfstate` file to understand what Terraform tracks.
  - Modify the bucket (e.g., add tags) and re-run `terraform apply`.
  - Observe the changes in the state file.

---

### Day 7: Basic VPC Setup - Create VPC and Subnet

- Understand the `aws_vpc` and `aws_subnet` resources.
- **Hands-On:**
  - Define a basic VPC and a public subnet in `main.tf`.
  - Run `terraform apply` to provision the resources.
  - Verify the VPC and subnet in the AWS Console.

---

### Day 8: Security Group - Allow SSH and HTTP Traffic

- Learn about the `aws_security_group` resource.
- **Hands-On:**
  - Create a security group allowing:
    - Inbound SSH (port `22`)
    - HTTP (port `80`) traffic
  - Apply the configuration and verify the rules in the AWS Console.

---

### Day 9: EC2 Instance - Launch in Your VPC

- Understand the `aws_instance` resource and `aws_ami` data source.
- **Hands-On:**
  - Use `aws_ami` data source to fetch the latest Amazon Linux AMI.
  - Define an `aws_instance` resource:
    - Specify the subnet ID and security group.
  - Run `terraform apply` and verify the instance in the AWS Console.

---

### Day 10: IAM Role - Grant S3 Read-Only Access to EC2

- Learn about:
  - `aws_iam_role`
  - `aws_iam_policy`
  - `aws_iam_policy_attachment`
- **Hands-On:**
  - Create an IAM role with a policy granting S3 read-only access.
  - Attach the policy to the role.
  - Associate the role with your EC2 instance.



### Day 11: Elastic Load Balancer (ELB) - Create and Target EC2

- Understand the following resources:
  - `aws_lb`
  - `aws_lb_target_group`
  - `aws_lb_listener`
  - `aws_lb_target_group_attachment`
- **Hands-On:**
  - Provision an Application Load Balancer (ALB).
  - Configure it to route traffic to your EC2 instance.
  - Verify load balancer access via public DNS.

---

### Day 12: Local Module - Create Reusable S3 Bucket Module

- Learn how to create and use **local Terraform modules**.
- **Hands-On:**
  - Create a `modules/s3_bucket/` directory with:
    - `main.tf`
    - `variables.tf`
    - `outputs.tf`
  - Define a reusable S3 bucket module.
  - Use the module in your root `main.tf`.

---

### Day 13: Public Module - Explore and Use a VPC Module from the Registry

- Learn about the **Terraform Module Registry**.
- **Hands-On:**
  - Search for an AWS VPC module on the [Terraform Registry](https://registry.terraform.io/).
  - Integrate the module into your configuration.
  - Configure required input variables and apply the setup.

---

### Day 14: Remote State - Configure S3 Backend for State Storage

- Understand the benefits of **remote state storage**.
- **Hands-On:**
  - Create an S3 bucket for storing Terraform state.
  - Configure the backend block with:
    ```hcl
    backend "s3" {
      bucket = "your-terraform-state-bucket"
      key    = "path/to/terraform.tfstate"
      region = "your-region"
    }
    ```
  - Run `terraform init -migrate-state` to migrate local state to the S3 bucket.

---

### Day 15: State Locking - Set Up DynamoDB for Concurrency Control

- Learn about **state locking** with **DynamoDB**.
- **Hands-On:**
  - Create a DynamoDB table with `LockID` as the primary key.
  - Update the `backend "s3"` configuration:
    ```hcl
    backend "s3" {
      bucket         = "your-terraform-state-bucket"
      key            = "path/to/terraform.tfstate"
      region         = "your-region"
      dynamodb_table = "terraform-locks"
    }
    ```
  - Run `terraform init -reconfigure` to apply backend changes.
## Week 4: Dynamic Configuration & Information (Days 16–20)

---

### Day 16: Provisioner (remote-exec) - Install a Basic Web Server on EC2

- Understand the usage of the `remote-exec` provisioner.
- **Hands-On:**
  - Add a `remote-exec` provisioner block to your `aws_instance`.
  - Use it to install a basic web server like **Nginx**.
  - Example:
    ```hcl
    provisioner "remote-exec" {
      inline = [
        "sudo apt update",
        "sudo apt install -y nginx",
        "sudo systemctl start nginx"
      ]
    }
    ```
  - Ensure your EC2 instance has SSH access set up.

---

### Day 17: Data Source (aws_ami) - Dynamically Lookup the Latest Amazon Linux AMI

- Learn how to use filters with the `aws_ami` data source.
- **Hands-On:**
  - Update your `aws_instance` to use this data source:
    ```hcl
    data "aws_ami" "amazon_linux" {
      most_recent = true

      filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
      }

      filter {
        name   = "virtualization-type"
        values = ["hvm"]
      }

      owners = ["amazon"]
    }
    ```
  - Use `data.aws_ami.amazon_linux.id` as the `ami` value.

---

### Day 18: Terraform Cloud - Sign Up and Connect Your Repository

- Explore **Terraform Cloud** for remote state management and collaboration.
- **Hands-On:**
  - Sign up for [Terraform Cloud](https://app.terraform.io/).
  - Create a workspace and connect it to your GitHub repo.
  - Update your project’s backend:
    ```hcl
    terraform {
      backend "remote" {
        organization = "your-org"

        workspaces {
          name = "your-workspace"
        }
      }
    }
    ```
  - Run `terraform init` to configure.

---

### Day 19: Terraform Workspaces - Manage Dev and Prod S3 Buckets

- Understand the concept of **Terraform Workspaces**.
- **Hands-On:**
  - Use `terraform workspace new dev` and `terraform workspace new prod`.
  - Parameterize your bucket name using the workspace:
    ```hcl
    bucket = "my-bucket-${terraform.workspace}"
    ```
  - Run `terraform apply` in each workspace to create separate S3 buckets.

---

### Day 20: Terraform Format and Style - Use terraform fmt and Understand Style Conventions

- Learn about **Terraform formatting and styling**.
- **Hands-On:**
  - Introduce indentation and spacing issues in your `.tf` files.
  - Run:
    ```bash
    terraform fmt
    ```
  - Observe how Terraform auto-formats your code.
  - Review [Terraform Style Guide](https://developer.hashicorp.com/terraform/language/syntax/style) for best practices.

## Week 5: Real-World Projects - Build and Deploy (Days 21–25)

---

### Days 21–25: Project 1 - Basic Web Application Infrastructure

#### 🎯 Goal:
Provision a basic infrastructure for a web application, including a VPC with public and private subnets, an EC2 instance in the private subnet, and a NAT Gateway in the public subnet.

---

### 🧠 Concepts Covered:
- VPC, Subnet (public & private)
- Internet Gateway and NAT Gateway
- Route Tables and Associations
- EC2 Instance in a private subnet
- Elastic IP allocation
- Security Groups

---

### 🛠 Hands-On Tasks:

1. **Create VPC and Subnets**
   - Define a custom VPC.
   - Create a **public** and a **private** subnet in different availability zones.

2. **Internet Gateway & Route Table (Public)**
   - Create and attach an Internet Gateway to your VPC.
   - Define a public route table and associate it with the public subnet.

3. **NAT Gateway & Route Table (Private)**
   - Allocate an Elastic IP.
   - Create a NAT Gateway in the public subnet.
   - Create a private route table that routes internet traffic via the NAT Gateway and associate it with the private subnet.

4. **EC2 Instance in Private Subnet**
   - Launch an EC2 instance in the **private subnet**.
   - Use a security group allowing **SSH** and **HTTP** from your IP (via NAT).

5. **Test Connectivity**
   - Use a bastion (jump) host or Session Manager to verify access to the instance.
   - Install a basic web server (e.g., nginx) using `remote-exec`.

---

### ✅ Validation:

- Confirm the private EC2 can access the internet via NAT Gateway.
- Access the public subnet from your local machine (if bastion is used).
- Use `terraform output` to get the private IP, NAT EIP, etc.

---

### 📦 Suggested File Structure:

## Project 1: Basic Web Application Infrastructure

### Folder Structure:

- **project1-basic-web-infra/**
  - **main.tf**                # Main configuration file for the infrastructure setup
  - **variables.tf**           # Define variables for reusable configurations (e.g., VPC CIDR block)
  - **outputs.tf**             # Output values for your infrastructure such as VPC ID, subnet IDs
  - **vpc.tf**                 # Configuration for creating the VPC (Virtual Private Cloud)
  - **subnets.tf**             # Configuration for subnets within the VPC (public/private)
  - **nat_gateway.tf**         # Configuration for creating a NAT Gateway for outbound internet access
  - **ec2.tf**                 # Configuration for launching an EC2 instance in the VPC
  - **security.tf**            # Configuration for security groups associated with EC2 instances
  - **terraform.tfvars**       # Define values for the variables (e.g., region, instance type, CIDR blocks)

## Week 5: Real-World Projects - Build and Deploy (Days 26–30)

---

### Days 26–30: Project 2 - Scalable Web Application with Load Balancer and Auto Scaling

#### 🎯 Goal:
Enhance the infrastructure from Project 1 by adding an **Application Load Balancer (ALB)** and an **Auto Scaling Group (ASG)** to ensure the web application can scale automatically based on traffic.

---

### 🧠 Concepts Covered:
- Application Load Balancer (ALB)
- Target Groups and Listeners
- Auto Scaling Group (ASG)
- Launch Configurations/Launch Templates
- Health Checks
- ALB with SSL (optional, but recommended)

---

### 🛠 Hands-On Tasks:

1. **Provision ALB**
   - Define an **Application Load Balancer** in your VPC.
   - Configure **listeners** for HTTP/HTTPS (optional).
   - Set up **target groups** to register EC2 instances.

2. **Security Group for ALB**
   - Create a new **security group** for the ALB allowing inbound HTTP/HTTPS (ports 80/443).

3. **Configure EC2 Auto Scaling Group**
   - Define an **Auto Scaling Group** for EC2 instances.
   - Use an **EC2 Launch Template** to define instance settings (AMI, instance type, security group).
   - Attach the EC2 instances to the **target group** of the ALB.

4. **Configure Health Checks**
   - Set up **health checks** to monitor the health of instances in the target group.
   - Ensure traffic is only routed to healthy instances.

5. **Test Scalability**
   - Monitor the **auto scaling** behavior by adjusting the desired capacity or triggering traffic.
   - Verify that new instances are spun up and removed based on traffic load.

---

### ✅ Validation:

- Ensure the ALB distributes traffic to EC2 instances.
- Check that new EC2 instances are launched when the load increases and terminated when it's low.
- Use `terraform output` to retrieve the URL for the load balancer and verify that it serves your application.

---

### 📦 Suggested File Structure:

## Project 2: Scalable Web Application with Load Balancer and Auto Scaling

### Folder Structure:

- **project2-scalable-web-app/**
  - **main.tf**                # Main configuration file for the infrastructure
  - **variables.tf**           # Define variables used throughout the configuration
  - **outputs.tf**             # Output values such as ALB DNS name, Auto Scaling Group details
  - **alb.tf**                 # Terraform configuration for provisioning the Application Load Balancer (ALB)
  - **asg.tf**                 # Terraform configuration for creating the Auto Scaling Group (ASG)
  - **security.tf**            # Configuration for security groups associated with the ALB and EC2 instances
  - **ec2_launch_template.tf** # Configuration for EC2 launch template used in the ASG
  - **terraform.tfvars**       # Define values for the variables (e.g., instance type, desired capacity)

---

## Project 1: Basic Web Application Infrastructure

### Folder Structure:

- **project1-basic-web-infra/**
  - **main.tf**                # Main configuration file for the infrastructure setup
  - **variables.tf**           # Define variables for reusable configurations (e.g., VPC CIDR block)
  - **outputs.tf**             # Output values for your infrastructure such as VPC ID, subnet IDs
  - **vpc.tf**                 # Configuration for creating the VPC (Virtual Private Cloud)
  - **subnets.tf**             # Configuration for subnets within the VPC (public/private)
  - **nat_gateway.tf**         # Configuration for creating a NAT Gateway for outbound internet access
  - **ec2.tf**                 # Configuration for launching an EC


## Week 6: Real-World Projects - Build and Deploy (Days 31–35)

---

### Days 31–35: Project 3 - Deploying a Static Website with S3 and CloudFront

#### 🎯 Goal:
Provision a **static website** using an **S3 bucket** for hosting, and configure **CloudFront** to distribute the website globally.

---

### 🧠 Concepts Covered:
- S3 Static Website Hosting
- CloudFront Distribution
- S3 Bucket Policies
- DNS Configuration (Route 53, optional)

---

### 🛠 Hands-On Tasks:

1. **Create an S3 Bucket for Static Website Hosting**
   - Provision an **S3 bucket** configured for **static website hosting**.
   - Configure **index.html** and **error.html** as the entry points.

2. **Upload Website Files to S3**
   - Use Terraform to upload **HTML**, **CSS**, and **JS** files into the S3 bucket.

3. **Configure Bucket Policy for Public Access**
   - Define a **bucket policy** to allow public access to the static website files.

4. **Provision a CloudFront Distribution**
   - Set up a **CloudFront distribution** to serve content from the S3 bucket.
   - Configure the **S3 bucket URL** as the origin of the distribution.
   - Optionally, configure SSL/TLS for secure access.

5. **DNS Configuration with Route 53 (Optional)**
   - If using Route 53, create a **DNS record** to map your custom domain to the CloudFront distribution.

---

### ✅ Validation:

- Access the **CloudFront URL** and ensure the static website is being served correctly.
- Verify that all the files (images, CSS, JS) load properly.
- If using Route 53, confirm that the custom domain resolves to the CloudFront distribution.

---

### 📦 Suggested File Structure:
## Project 3: Deploying a Static Website with S3 and CloudFront

### Folder Structure:

- **project3-static-website/**
  - **main.tf**                # Main configuration file for the infrastructure
  - **variables.tf**           # Define variables used throughout the configuration
  - **outputs.tf**             # Output values from the configuration (e.g., S3 bucket URL, CloudFront distribution URL)
  - **s3.tf**                  # Terraform configuration for provisioning the S3 bucket for static website hosting
  - **cloudfront.tf**          # Terraform configuration for setting up CloudFront distribution for the static website
  - **route53.tf (optional)**  # Configuration for DNS management using Route 53 (optional)
  - **terraform.tfvars**       # Define values for the variables (e.g., domain name, region)


## Week 7: Real-World Projects - Build and Deploy (Days 36–40)

---

### Days 36–40: Project 4 - Building a Simple Database Infrastructure (RDS)

#### 🎯 Goal:
Provision an **Amazon RDS** instance (e.g., **PostgreSQL** or **MySQL**) and configure necessary **security group access** for the database.

---

### 🧠 Concepts Covered:
- RDS Instance Creation
- Security Group Configuration
- Parameter Group for Custom Database Settings
- IAM Roles for RDS (optional)
- Database Backups & Snapshots

---

### 🛠 Hands-On Tasks:

1. **Provision an RDS Instance**
   - Create an **RDS instance** using Terraform.
   - Choose a suitable database engine (PostgreSQL or MySQL).
   - Specify key configurations such as **instance type**, **storage type**, **username**, **password**, and **database name**.

2. **Configure Security Groups for Database Access**
   - Define a **security group** that allows inbound connections on the appropriate port (e.g., **5432** for PostgreSQL, **3306** for MySQL).
   - Attach the security group to your RDS instance.

3. **Backup and Snapshot Configuration (Optional)**
   - Configure automatic **backups** for the RDS instance.
   - Optionally, create a manual snapshot of the database after provisioning.

4. **Parameter Group Configuration (Optional)**
   - Create a custom **parameter group** for your RDS instance to adjust default database settings (e.g., max connections, query cache).

5. **IAM Role (Optional)**
   - If necessary, create an **IAM role** and assign it to your RDS instance for additional features like S3 integration or IAM database authentication.

---

### ✅ Validation:

- Confirm the **RDS instance** is available by connecting to the database using a client like **pgAdmin** (for PostgreSQL) or **MySQL Workbench** (for MySQL).
- Check that the **security group** allows access from your IP address.
- Verify **backups** and **snapshots** are working as expected (optional).
- If IAM role is used, ensure it is functioning correctly.

---

### 📦 Suggested File Structure:

## Project 4: Building a Simple Database Infrastructure (RDS)

### Folder Structure:

- **project4-db-infrastructure/**
  - **main.tf**                # Main configuration file for the infrastructure
  - **variables.tf**           # Define variables used throughout the configuration
  - **outputs.tf**             # Output values from the configuration (e.g., RDS endpoint)
  - **rds.tf**                 # Terraform configuration for provisioning the RDS instance
  - **security_groups.tf**     # Terraform configuration for security groups
  - **backups.tf (optional)**  # Configuration for automated backups and manual snapshots (optional)
  - **parameter_group.tf (optional)**  # Custom parameter group configuration for the RDS instance (optional)
  - **iam.tf (optional)**      # IAM role for RDS instance (optional)
  - **terraform.tfvars**       # Define values for the variables (e.g., RDS credentials, instance type)
