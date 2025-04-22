

# Day 3: Managing AWS VPC and Subnets with Terraform

### Learning Objectives:
- Learn to create a Virtual Private Cloud (VPC) using Terraform.
- Understand how to provision subnets, route tables, and internet gateways.

---

### Learning Topics:
1. **Creating a VPC**:
   - Define a VPC with specific CIDR blocks.
   - Configure multiple subnets within the VPC.

2. **Configuring Route Tables and Gateways**:
   - Create route tables and associate them with subnets.
   - Configure an internet gateway for internet access to instances in the VPC.

3. **Subnetting**:
   - Learn about private vs public subnets and how to configure them using Terraform.

---

### Real-World Use Cases:
1. **VPC for Multi-Tier Applications**:
   - VPCs are used to isolate and manage network configurations for different layers of an application (e.g., frontend, backend, database).

2. **Security and Network Isolation**:
   - Private subnets within a VPC are used to keep sensitive resources (e.g., databases) isolated from the public internet, while public subnets host web-facing applications.

---

### Interview Questions & Answers:

1. **Q: What is a VPC in AWS?**
   - **A**: A VPC (Virtual Private Cloud) is a logically isolated network in the AWS cloud. It enables you to define and control your virtual network, including aspects such as IP address range, subnets, route tables, and network gateways.

2. **Q: What is the difference between a public and private subnet?**
   - **A**: A public subnet is a subnet that has direct access to the internet via an Internet Gateway, while a private subnet does not have direct internet access and relies on NAT or other configurations for outbound access.

3. **Q: How does Terraform manage state for AWS resources?**
   - **A**: Terraform manages the state of the AWS infrastructure in a state file, which is used to track and compare the current configuration with the desired configuration. This allows Terraform to manage updates and deletions of resources.

---

### Troubleshooting Issues & Solutions:

1. **Issue**: VPC creation fails with an error `CIDR block overlaps with existing VPC`.
   - **Solution**: Ensure that the CIDR block you're using does not overlap with any existing VPCs in the AWS region. You can check your current VPC CIDRs in the AWS console and choose a different range.

2. **Issue**: EC2 instance in the private subnet cannot reach the internet.
   - **Solution**: Ensure that a NAT Gateway is set up for the private subnet if you require internet access. For public subnets, ensure that the route table is correctly associated and that an Internet Gateway is attached to the VPC.

3. **Issue**: The VPC creation does not work due to lack of permissions.
   - **Solution**: Make sure the IAM user or role running Terraform has sufficient permissions for creating and managing VPCs, subnets, and other networking resources.

---

### Hands-On Tasks:
1. **Create VPC**:
   ```hcl
   resource "aws_vpc" "main" {
     cidr_block = "10.0.0.0/16"
     enable_dns_support = true
     enable_dns_hostnames = true
   }
    resource "aws_subnet" "subnet_public" {
    vpc_id     = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-west-2a"
    map_public_ip_on_launch = true
    }
    resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    }
```
