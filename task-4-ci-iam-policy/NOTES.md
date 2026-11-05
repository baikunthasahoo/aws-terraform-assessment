
# Task 4: Least-Privilege IAM Policy

## Objective

The custom IAM policy provides the CI user with only the
permissions required to push Docker images to ECR, deploy
an ECS task definition, update a specific ECS service,
and read build artifacts from a designated S3 bucket.

## Permissions Included

### 1. ECR

- ecr:GetAuthorizationToken
- ecr:BatchCheckLayerAvailability
- ecr:InitiateLayerUpload
- ecr:UploadLayerPart
- ecr:CompleteLayerUpload
- ecr:PutImage

These permissions allow Docker authentication and image
uploads to the specific ECR repository.

GetAuthorizationToken requires Resource "*".
Image upload permissions are restricted to one repository.

### 2. ECS

- ecs:RegisterTaskDefinition
- ecs:DescribeTaskDefinition
- ecs:UpdateService
- ecs:DescribeServices

These permissions allow the pipeline to register a new
task definition and update the specified ECS service.

### 3. IAM PassRole

- iam:PassRole

This permission allows ECS to use only the specified
task execution role and task role.

The iam:PassedToService condition restricts passing
these roles to ecs-tasks.amazonaws.com.

### 4. S3

- s3:ListBucket
- s3:GetObject

These permissions allow the pipeline to list and download
build artifacts from the specified S3 bucket.

## Permissions Deliberately Excluded

1. ECR repository administration:
   No repository creation, deletion, or policy modification.

2. ECS cluster administration:
   No cluster creation, deletion, or modification.

3. ECS service administration:
   No permission to create or delete services.

4. IAM administration:
   No user, group, role, or policy creation or modification.
   PassRole is restricted to two specific ECS roles.

5. S3 write access:
   No PutObject, DeleteObject, or bucket modification.

6. EC2 administration:
   No EC2 instance, security group, or networking permissions.

7. CloudWatch administration:
   No log group creation, deletion, or log configuration changes.

## Security Approach

The policy follows the principle of least privilege.

Permissions are restricted to specific resources wherever
AWS supports resource-level permissions.

Wildcard resources are used only where required by AWS,
such as ecr:GetAuthorizationToken.

The CI user cannot administer unrelated AWS services
or access unrelated application resources.
