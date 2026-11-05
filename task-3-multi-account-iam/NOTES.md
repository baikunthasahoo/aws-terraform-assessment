
# Task 3: Multi-Account IAM and Cross-Account Access

## 1. Would you use IAM users with access keys for engine and ci in production?

No. I would avoid long-lived IAM user access keys in a
production environment wherever possible.

My preferred approach would be:

- For EC2 workloads, use IAM roles through instance profiles.
- For CI/CD pipelines, use OIDC federation to assume IAM
  roles and obtain temporary credentials.
- For human users, use AWS IAM Identity Center.

This approach reduces the risk of leaked credentials,
avoids manual access-key rotation, and follows the
principle of least privilege.

## 2. Why trust roleB's specific ARN instead of Account A root?

Trusting the Account A root principal allows Account A
to delegate access to roleC to its IAM principals through
identity-based permissions.

Trusting roleB's specific ARN restricts the trusted
principal to that particular role.

This provides tighter access control, follows the
principle of least privilege, and reduces the risk of
unintended cross-account access.
