
# Day 4: Managing AWS S3 Buckets with Terraform

### Learning Objectives:
- Learn to manage AWS S3 buckets using Terraform.
- Understand how to set permissions and lifecycle rules for S3 buckets.

---

### Learning Topics:
1. **Creating S3 Buckets**:
   - Learn how to define an S3 bucket in Terraform.
   - Set configurations like region, ACL, and versioning.

2. **Setting Bucket Policies**:
   - Understand how to apply IAM policies to control access to S3 buckets.

3. **Lifecycle Management**:
   - Set up lifecycle rules for object storage (e.g., transitioning to different storage classes).

---

### Real-World Use Cases:
1. **Backup and Storage**:
   - S3 buckets are commonly used to store backups of databases, logs, and application data. Terraform can automate the provisioning and configuration of these buckets.

2. **Static Website Hosting**:
   - S3 can also be used to host static websites. Terraform can automate the setup of the bucket and enable static website hosting.

---

### Interview Questions & Answers:

1. **Q: How do you create a versioned S3 bucket using Terraform?**
   - **A**: You can create a versioned S3 bucket by setting the `versioning` block in the S3 bucket resource:
     ```hcl
     resource "aws_s3_bucket" "example" {
       bucket = "my-unique-bucket-name"
       versioning {
         enabled = true
       }
     }
     ```

2. **Q: What is an ACL in S3 and how is it used in Terraform?**
   - **A**: An ACL (Access Control List) in S3 defines the permissions for an S3 bucket. It can be set in Terraform using the `acl` attribute in the `aws_s3_bucket` resource to grant predefined permissions (e.g., `private`, `public-read`).

---

### Troubleshooting Issues & Solutions:

1. **Issue**: Terraform fails to create an S3 bucket with the error `BucketAlreadyExists`.
   - **Solution**: S3 bucket names must be globally unique. Try changing the bucket name to something more unique.

2. **Issue**: The S3 bucket is not accessible after creation.
   - **Solution**: Verify the bucket's ACL and permissions to ensure that the necessary access is granted. Check the IAM policies and ensure the user has the correct permissions.

---

### Hands-On Tasks:
1. **Create S3 Bucket**:
   ```hcl
   resource "aws_s3_bucket" "example" {
     bucket = "my-unique-bucket-name"
     acl    = "private"
   }
   resource "aws_s3_bucket" "example_versioned" {
    bucket = "my-unique-bucket-name-versioned"
    versioning {
      enabled = true
      }
    }
   ```

