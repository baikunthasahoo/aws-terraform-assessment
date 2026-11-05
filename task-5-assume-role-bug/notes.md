# Task 5: Find and Fix the Bug

## Objective

Review the Terraform code and fix the issues preventing `roleB` in Account A from assuming `roleC` in Account B.

## Issues Found and Fixes

### 1. Incorrect IAM Role ARN

The trust policy was using this ARN:

`arn:aws:iam::000000000000:user/roleB`

The problem is that `roleB` is an IAM role, not an IAM user. So the ARN should use `role` instead of `user`.

Correct ARN:

`arn:aws:iam::000000000000:role/roleB`

I updated the trust policy to use the correct ARN so that Account B can identify and trust the intended role from Account A.

### 2. Incorrect Terraform Role Reference

The original snippet had an incorrectly formatted reference for the `role` attribute.

It should be:

`role = aws_iam_role.roleC.id`

This tells Terraform to attach the inline policy to the `roleC` resource created in the same configuration.

### 3. S3 Permissions Were Too Broad

The original policy used:

`Resource = "*"`

This is broader than required because it does not restrict access to a particular S3 bucket.

I changed it to include only the ARN of the required bucket and its objects. This keeps the permissions limited to the resource that `roleC` actually needs to access.

## Expected Result

After these changes:

- Terraform creates `roleC` in Account B.
- The trust policy allows `roleB` from Account A to assume it.
- The inline S3 policy is attached to the correct role.
- S3 access is restricted to the specified bucket and its objects.

## Cross-Account Access

There is one more thing to consider. Updating the trust policy in Account B alone is not enough.

The `roleB` role in Account A must also have an identity policy allowing it to call `sts:AssumeRole` on `roleC`.

So both conditions must be met:

1. `roleB` in Account A must have permission to assume `roleC`.
2. `roleC` in Account B must trust `roleB`.

With both sides configured correctly, the cross-account role assumption can work.