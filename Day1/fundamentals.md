# Fundamentals of Terraform

This document outlines the fundamental topics you should aim to cover in your 40-day Terraform learning journey.

## Core Terraform Concepts

### Terraform Configuration Language (HCL)

* **Syntax and Structure of `.tf` files:** Basic structure, comments, and organization.
* **Blocks, Arguments, and Expressions:** Understanding the building blocks of HCL.
* **Data Types:** Strings, numbers, booleans, lists (`[]`), maps (`{}`), and objects.
* **Variables:**
    * Defining input variables (`variable "..." { ... }`).
    * Using variables in configurations (`var.variable_name`).
    * Different variable types and constraints.
    * Local variables (`locals { ... }`).
    * Output values (`output "..." { ... }`).
* **Data Sources:** Reading information about existing infrastructure (`data "..." "..." { ... }`).
* **Output Values:** Exposing information after deployment (`output "..." { ... }`).
* **Functions:** Built-in functions for manipulating data (e.g., `join`, `length`, `lookup`).
* **Conditionals and Loops (basic usage):** `count` meta-argument, basic `for` expressions.

### Terraform State

* **What is Terraform state and why is it important?** Tracking the managed infrastructure.
* **Local state vs. remote state:** Understanding the implications and benefits of remote state.
* **State backends:** Configuring different backends (e.g., `s3`, `azurerm`, `gcs`).
* **State locking:** Preventing concurrent modifications to the state.
* **State commands:**
    * `terraform state list`
    * `terraform state show <resource_address>`
    * `terraform state mv <source> <destination>`
    * `terraform state rm <address>` (use with caution)
* **State drift and how to manage it:** Situations where the actual infrastructure differs from the state file.

### Terraform Modules

* **What are modules and why use them?** Reusability, organization, and abstraction.
* **Creating and using your own modules:** Defining input variables, output values, and the module's configuration.
* **Using modules from the Terraform Registry:** Leveraging pre-built modules.
* **Module inputs and outputs:** Passing data into and out of modules.
* **Module versioning:** Managing different versions of modules.

### Terraform Providers

* **Deep dive into the AWS provider:** Exploring common resources and configurations.
* **Understanding provider versions and how to manage them:** Specifying provider versions in the `required_providers` block.
* **Exploring other common providers:** Briefly understanding the purpose of providers like Azure, GCP, Docker, and Kubernetes.

### Terraform Workflow

* `terraform init`: Initializing the working directory.
* `terraform plan`: Generating and reviewing the execution plan.
* `terraform apply`: Applying the changes to create or modify infrastructure.
* `terraform destroy`: Deleting managed infrastructure.
* `terraform fmt`: Formatting Terraform code to adhere to a standard style.
* `terraform validate`: Checking the syntax and basic validity of Terraform configurations.

### Resource Management

* **Resource dependencies (`depends_on`):** Explicitly defining dependencies between resources.
* **Lifecycle rules (`create_before_destroy`, `prevent_destroy`):** Controlling the lifecycle behavior of resources.
* **Importing existing resources into Terraform (`terraform import`):** Managing infrastructure that wasn't initially created by Terraform.

### Provisioners and Local Exec

* **Understanding when and how to use provisioners:** Executing scripts on the provisioned infrastructure (use with caution).
* `remote-exec` provisioner: Executing commands on remote instances.
* `local-exec` provisioner: Executing commands on the local machine.

### Terraform Cloud (Optional but Recommended)

* Overview of Terraform Cloud features: Remote state management, collaboration, automation, Sentinel policy as code.
* Setting up a basic Terraform Cloud account and workspace.
* Connecting your Terraform configurations to Terraform Cloud.

## AWS Specific Concepts (to deepen your understanding)

* **IAM (Identity and Access Management):** Roles, policies, users (relevant for Terraform's access to AWS and managing IAM resources).
* **Networking (VPC, Subnets, Security Groups, Route Tables):** Building and managing your virtual network infrastructure.
* **Compute (EC2 Instances, Auto Scaling Groups, Launch Templates/Configurations):** Deploying and scaling virtual machines.
* **Storage (S3, EBS, EFS):** Understanding different storage options and managing them.
* **Databases (RDS, DynamoDB):** Provisioning and managing managed database services.
* **Load Balancers (ELB - Application, Network, Classic):** Distributing traffic across your compute resources.

## Best Practices

* **Version Control (Git):** Storing and managing your Terraform code in Git repositories.
* **Code Style and Conventions:** Following consistent formatting and naming conventions.
* **Testing:** Implementing basic testing strategies for your Terraform configurations (e.g., using `terraform plan` for verification).
* **Security Best Practices:** Securely managing AWS credentials and sensitive information (e.g., using Terraform Cloud secrets, avoiding hardcoding).
* **Idempotency:** Understanding that Terraform configurations should be able to be applied multiple times with the same result.

## Tips for Your Learning Journey

* **Hands-on Practice:** Build real infrastructure in your AWS account (remember to clean up afterwards!).
* **Refer to Official Documentation:** The Terraform and AWS documentation are your best resources.
* **Join the Community:** Participate in forums and online communities to ask questions and learn from others.
* **Break Down Complex Topics:** Tackle one concept at a time.
* **Set Realistic Goals:** A 40-day plan is a great start, but continuous learning is key.