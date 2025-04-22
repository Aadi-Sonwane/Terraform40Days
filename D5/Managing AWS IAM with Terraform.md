
# Day 5: Managing AWS IAM with Terraform

### Learning Objectives:
- Learn to create and manage IAM users, groups, and roles using Terraform.
- Understand how to assign permissions using IAM policies.

---

### Learning Topics:
1. **Creating IAM Users**:
   - Learn how to define IAM users with access keys, and manage user permissions.

2. **Managing IAM Roles**:
   - Understand how to create IAM roles with specific policies and assign them to resources.

3. **IAM Policies**:
   - Learn to create IAM policies to control permissions for AWS resources.

---

### Real-World Use Cases:
1. **Access Management**:
   - IAM allows fine-grained control over who can access AWS resources and what actions they can perform. Terraform helps automate the creation of IAM roles, users, and policies to enforce security best practices.

2. **Role-Based Access Control**:
   - Terraform can automate the assignment of roles to users or EC2 instances, ensuring secure access to resources based on the principle of least privilege.

---

### Interview Questions & Answers:

1. **Q: What is IAM in AWS?**
   - **A**: IAM (Identity and Access Management) is a web service that helps securely control access to AWS resources. It allows you to manage users, groups, roles, and permissions to control access to AWS services and resources.

2. **Q: How do you assign permissions in AWS using Terraform?**
   - **A**: Permissions are assigned using IAM policies. These policies can be attached to IAM users, groups, or roles. You can create policies in Terraform using the `aws_iam_policy` resource and attach them to the appropriate entities.

---

### Troubleshooting Issues & Solutions:

1. **Issue**: Terraform throws an error `AccessDenied` when creating IAM resources.
   - **Solution**: Ensure the IAM user or role running Terraform has sufficient permissions for IAM actions, such as `iam:CreateUser`, `iam:CreateRole`, and `iam:AttachRolePolicy`.

2. **Issue**: IAM role is not assuming correctly.
   - **Solution**: Ensure that the trust policy for the role is correctly configured to allow the service (e.g., EC2) to assume the role.

---

### Hands-On Tasks:
1. **Create IAM User**:
   ```hcl
   resource "aws_iam_user" "example" {
     name = "example-user"
   }
   
   resource "aws_iam_role" "example" {
   name               = "example-role"
   assume_role_policy = data.aws_iam_policy_document.example_role_assume.json
   }
```
