# Day 1: Introduction to Terraform & AWS Configuration

### Learning Objectives:
- Understand the basics of Terraform.
- Set up and configure Terraform with AWS.
- Learn about the configuration files and the basic syntax of HCL (HashiCorp Configuration Language).

---

### Learning Topics:
1. **Terraform Basics**:
   - Introduction to Infrastructure as Code (IaC).
   - Terraform architecture and components (Provider, Resources, State).
   - Terraform CLI commands (`init`, `plan`, `apply`, `destroy`).

2. **AWS Provider Configuration**:
   - Set up AWS credentials (using environment variables or `~/.aws/credentials`).
   - Configure the AWS provider in Terraform.

3. **Terraform State**:
   - Introduction to the `terraform.tfstate` file.
   - Importance of state management and remote state.

---

### Real-World Use Cases:
1. **Infrastructure Automation**:
   - Terraform can automate the deployment and management of infrastructure, ensuring consistency and repeatability across environments (e.g., staging, production).

2. **Multi-Cloud Management**:
   - Terraform allows for the management of resources across multiple cloud providers, enabling a multi-cloud strategy to avoid vendor lock-in.

---

### Interview Questions & Answers:

1. **Q: What is Terraform and why is it used?**
   - **A**: Terraform is an open-source IaC tool that allows you to define and provision data center infrastructure using a declarative configuration language (HCL). It is used to automate infrastructure provisioning, ensure consistency, and version infrastructure changes.

2. **Q: How does Terraform manage state?**
   - **A**: Terraform maintains the state of the infrastructure in a file (`terraform.tfstate`). The state is used to keep track of what resources have been created and manage future updates. It is crucial for Terraform’s operation as it helps in planning and applying changes efficiently.

3. **Q: What is the purpose of the `terraform plan` command?**
   - **A**: The `terraform plan` command is used to preview the changes Terraform will make to the infrastructure before actually applying them. It helps in understanding the impact of any changes made to the configuration files.

---

### Troubleshooting Issues & Solutions:

1. **Issue**: Terraform fails to initialize with `Error: No valid credential sources found for AWS provider`.
   - **Solution**: Ensure AWS credentials are properly configured. Use environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`) or configure them in the AWS credentials file (`~/.aws/credentials`).

2. **Issue**: Terraform plan shows a `Resource already exists` error.
   - **Solution**: The resource may have been manually created or configured. Ensure that the resource is properly defined in your Terraform configuration or import the existing resource using `terraform import`.

---

### Hands-On Tasks:
1. **Set up AWS Provider**:
   ```hcl
   provider "aws" {
     region = "us-west-2"
   }
   ```
2. **Create Ec2 instance**;
   ```hcl
   resource "aws_instance" "example" {
   ami = "ami-id"
   instance_type = "t2.micro"
   }
   ```
3. **Run terraform command**'
   ```bash
   terraform init
   terraform plan
   terraform apply
  ```



