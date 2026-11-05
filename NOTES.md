# AWS Terraform Assessment: Implementation Summary

## Task 1 - Multi-Instance EC2

- Created five EC2 instances using a single input map.
- Used `for_each` to manage the instances without repeating the same resource configuration.
- Kept the EC2 configuration in a reusable module.
- Passed different instance types, root volume sizes and key pairs through the input variables.
- Used `io1` storage for the production instance.
- Added Name, Environment and Owner tags to identify the instances.

### Lifecycle Protection

I added `prevent_destroy = true` for the `ec2-production` instance to avoid accidental deletion of the production environment.

The remaining instances can be updated or destroyed through the normal Terraform workflow.

## Task 2 - Remote State Management

- Configured an S3 bucket to store the Terraform state file.
- Enabled versioning so previous state versions can be recovered if needed.
- Enabled encryption for state file protection.
- Configured DynamoDB-based state locking to avoid multiple Terraform operations modifying the state at the same time.
- Updated the Terraform backend configuration to use the remote state.

### State Management

The main reason for using remote state is to keep the infrastructure state in a shared location instead of relying on a local file.

State locking also helps avoid conflicts when multiple team members or automation pipelines run Terraform.

## Task 3 - Multi-Account IAM and Cross-Account Access

- Created four IAM users in Account A: `engine`, `ci`, `developer1` and `developer2`.
- Created `group1` and added `engine` and `ci` to it.
- Created `group2` and added `developer1` and `developer2` to it.
- Created `roleA` with access to AWS services, excluding IAM actions.
- Created `roleB` with permission to assume `roleC` in Account B.
- Created `roleC` in Account B and granted it access to the required S3 bucket.

### Cross-Account Access

For the trust relationship, I used the ARN of `roleB` in the trust policy of `roleC`.

I kept the trust limited to that specific role rather than trusting the entire Account A. This makes the access more restrictive and follows the least-privilege approach.

## Task 4 - Least-Privilege IAM Policy

Created a custom IAM policy for the `ci` user based on the permissions needed for the deployment process.

- Allowed the CI user to authenticate with ECR and push Docker images to the specified repository.
- Allowed registration of ECS task definitions and updates to the specified ECS service.
- Provided read-only access to the S3 build artifacts bucket.
- Restricted `iam:PassRole` to the ECS task execution role and task role.
- Added the `iam:PassedToService` condition to ensure those roles can only be passed to ECS tasks.

### Permissions Considered

I avoided giving the CI user permissions to create or delete IAM resources, manage ECR repositories, modify S3 artifacts or create and delete ECS infrastructure.

The idea was to give the pipeline enough access to build and deploy the application without granting it unnecessary administrative permissions.

## Task 5 - Find and Fix the Bug

Reviewed the supplied Terraform code and identified three issues.

- The trust policy used `user/roleB` instead of `role/roleB`. Since `roleB` is an IAM role, I corrected the principal ARN.
- Fixed the Terraform reference to `aws_iam_role.roleC.id` so the inline policy attaches to the correct role.
- Replaced the S3 `Resource = "*"` with the ARN of the specific bucket and its objects.

### Cross-Account Access Check

One important point is that the trust policy alone does not complete the cross-account setup.

The `roleB` policy in Account A must allow `sts:AssumeRole` on `roleC`, and the trust policy of `roleC` in Account B must allow `roleB` to assume it.

Both configurations are required for the cross-account access to work.