
# Day 2: Managing AWS Infrastructure with Terraform (EC2 Instance)

### Learning Objectives:
- Learn to provision and manage AWS resources with Terraform.
- Understand how to set up an EC2 instance using Terraform.
- Manage AWS credentials and security practices in Terraform.

---

### Learning Topics:
1. **AWS Provider Setup**:
   - Configure AWS provider in Terraform.
   - Use AWS credentials to manage AWS resources.

2. **Provisioning EC2 Instances**:
   - Define resources for creating an EC2 instance in Terraform.
   - Use attributes like `ami`, `instance_type`, and `tags`.

3. **Managing Security Groups**:
   - Create security groups and associate them with EC2 instances.
   - Understand inbound and outbound rules for security groups.

---

### Real-World Use Cases:
1. **Infrastructure Provisioning**:
   - Terraform is used to automate the creation of EC2 instances, making it easier to scale applications, test environments, or automate the provisioning of infrastructure across multiple environments (e.g., dev, staging, prod).

2. **Security Configuration**:
   - Security Groups in AWS control the access to EC2 instances. Managing these in Terraform allows for repeatable, version-controlled changes to security policies across environments.

---

### Interview Questions & Answers:

1. **Q: What is the `aws` provider in Terraform?**
   - **A**: The `aws` provider is a plugin used by Terraform to interact with AWS services. By configuring the provider, Terraform can create, manage, and destroy resources like EC2 instances, S3 buckets, etc., on AWS.

2. **Q: How do you manage AWS credentials in Terraform?**
   - **A**: AWS credentials can be managed using environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`), or via the `~/.aws/credentials` file. Alternatively, IAM roles can be used for EC2 instances running Terraform.

3. **Q: What is a Security Group in AWS?**
   - **A**: A Security Group acts as a virtual firewall to control inbound and outbound traffic to AWS resources like EC2 instances. You can define rules to allow or deny traffic based on protocols, IP ranges, and ports.

---

### Troubleshooting Issues & Solutions:

1. **Issue**: Terraform throws an error like `Error: UnauthorizedAccessException` when applying AWS resources.
   - **Solution**: Verify that the AWS credentials provided have sufficient permissions (e.g., `ec2:RunInstances`, `ec2:DescribeInstances`). Ensure the credentials are correctly configured and the IAM user/role has the necessary permissions.

2. **Issue**: The EC2 instance fails to launch with an error: `Error: Unable to locate the instance type`.
   - **Solution**: Double-check the `instance_type` attribute in your configuration file. Ensure you’re using a valid EC2 instance type available in the AWS region you’re provisioning the instance.

3. **Issue**: Terraform is not able to find the AMI (Amazon Machine Image).
   - **Solution**: Ensure that the AMI ID used is correct and available in the region you are trying to deploy the EC2 instance. You can manually verify the AMI in the AWS Console or use a data source in Terraform to fetch the latest AMI ID.

4. **Issue**: Security Group rules are not applied correctly.
   - **Solution**: Make sure the Security Group is correctly associated with the EC2 instance in your Terraform configuration. Use `terraform show` to inspect the configuration and verify if any changes were not applied.

---

### Hands-On Tasks:
1. **Set up AWS Provider**:
   ```hcl
   provider "aws" {
     region = "us-west-2"
   }
   resource "aws_instance" "example" {
   ami           = "ami-0c55b159cbfafe1f0"  # Replace with a valid AMI ID
   instance_type = "t2.micro"

    tags = {
      Name = "TerraformExample"
    }
   }
    resource "aws_security_group" "allow_ssh" {
    name        = "allow_ssh"
    description = "Allow SSH access"

    ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
   }

   
```
