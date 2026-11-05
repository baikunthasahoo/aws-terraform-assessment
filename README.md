# AWS Terraform Assessment

This repository contains my solutions for the AWS Terraform assessment. It covers EC2 provisioning, remote state management, IAM configuration, cross-account access and IAM policy troubleshooting.

I have kept the configurations modular where possible and used variables and reusable resources to avoid unnecessary repetition.

## Tasks Covered

### Task 1: Multi-Instance EC2
- Provisioned five EC2 instances using a single input map and `for_each`.
- Used a reusable EC2 module.
- Configured different instance types, root volumes and key pairs.
- Applied common tags to identify resources.
- Added lifecycle protection to the production instance using `prevent_destroy`.

### Task 2: Remote State Management
- Configured an S3 backend for storing Terraform state.
- Enabled S3 bucket versioning and encryption.
- Configured DynamoDB-based state locking to prevent concurrent state modifications.

### Task 3: Multi-Account IAM and Cross-Account Access
- Created IAM users and groups in Account A.
- Configured `roleA` with administrative access excluding IAM actions.
- Created `roleB` to allow access to a role in Account B.
- Created `roleC` in Account B with access to a specific S3 bucket.
- Configured the cross-account trust relationship between `roleB` and `roleC`.

### Task 4: Least-Privilege IAM Policy
- Created a custom policy for the CI user.
- Allowed Docker image push operations to a specific ECR repository.
- Allowed ECS task definition registration and service updates.
- Provided read-only access to the S3 build artifacts bucket.
- Restricted `iam:PassRole` to the required ECS task roles.

### Task 5: Find and Fix the Bug
- Reviewed the provided Terraform configuration.
- Corrected the IAM role principal ARN.
- Fixed the Terraform role resource reference.
- Restricted S3 permissions to the required bucket and objects.
- Documented the cross-account trust and permission requirements.

## Repository Structure

```text
aws-terraform-assessment/
│
├── task-1-ec2/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── modules/
│       └── ec2/
│
├── task-2-remote-state/
│   ├── main.tf
│   ├── backend.tf
│   └── variables.tf
│
├── task-3-iam/
│   ├── account-a/
│   ├── account-b/
│   └── NOTES.md
│
├── task-4-ci-iam-policy/
│   ├── ci-policy.json
│   └── NOTES.md
│
├── task-5-assume-role-bug/
│   ├── broken.tf
│   ├── fixed.tf
│   └── NOTES.md
│
└── README.md
```

*The structure above is a reference. Update the folder and file names if your actual repository uses a different layout.*

## Prerequisites

Before running the Terraform configurations, make sure you have:

- Terraform installed.
- AWS CLI installed and configured.
- An AWS account with the required permissions.
- AWS credentials configured for the relevant account.
- Access to the required AWS region.
- Existing or prepared backend resources where required.

## AWS Configuration

For the multi-account task, configure separate AWS CLI profiles for Account A and Account B.

Example `~/.aws/config`:

```ini
[profile account-a]
region = us-east-1

[profile account-b]
region = us-east-1
```

Configure the corresponding credentials using the AWS CLI or another approved credential method.

Verify the active account before running Terraform:

```bash
aws sts get-caller-identity --profile account-a

aws sts get-caller-identity --profile account-b
```

**Important:** The account IDs used in the assessment, `000000000000` and `111111111111`, are placeholders. Replace them with the actual AWS account IDs before deployment.

## How to Validate the Terraform Code

From the relevant task directory, run:

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
```

Review the execution plan before applying any changes.

To deploy after reviewing the plan:

```bash
terraform apply
```

For configurations that use separate AWS accounts, make sure the correct AWS profile is selected before running Terraform.

## Security Considerations

- Avoid committing AWS access keys, secrets or credentials to Git.
- Use IAM roles or temporary credentials wherever possible.
- Keep IAM permissions limited to the resources required.
- Enable encryption and versioning for Terraform state storage.
- Review Terraform plans before applying changes.
- Do not use placeholder account IDs or bucket names in a real deployment.
- Protect Terraform state because it may contain sensitive information.

## Notes

These configurations were prepared for the assessment requirements. Resource names, account IDs, regions and other environment-specific values may need to be updated before deployment.

The Terraform configurations should be validated and reviewed against the target AWS environment before applying them.