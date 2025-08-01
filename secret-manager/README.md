# Secret Manager Example

This repository demonstrates how to securely fetch secrets from AWS Secrets Manager and use them in your Python applications and GitHub Actions workflows.

---

## Contents

- `app.py`: Python script to retrieve secrets from AWS Secrets Manager and connect to a MySQL database.
- `.github/workflows/access-secrets.yml`: GitHub Actions workflow to fetch secrets from AWS Secrets Manager using OIDC authentication.

---

## Prerequisites

- **AWS Account** with Secrets Manager and IAM permissions.
- **MySQL Database** (RDS or self-hosted).
- **GitHub Repository** with Actions enabled.
- **Python 3.7+** and required libraries (`boto3`, `pymysql`).
- **AWS CLI** (for local testing or workflow usage).

---

## Python Application (`app.py`)

This script retrieves database credentials from AWS Secrets Manager and connects to a MySQL database.

### How it works

1. **Fetch Secret:**  
   Uses `boto3` to retrieve a secret (expected to be a JSON object with keys like `host`, `username`, `password`, `dbname`, and optionally `port`).

2. **Connect to MySQL:**  
   Uses `pymysql` to connect to the database using the retrieved credentials.

3. **Query Database:**  
   Executes a simple query (`SELECT NOW();`) and prints the current database time.

### Usage

1. **Install dependencies:**
   ```sh
   pip install boto3 pymysql
   ```

2. **Set environment variable:**
   ```sh
   export SECRET_NAME=your-secret-name
   ```

3. **Run the script:**
   ```sh
   python app.py
   ```

4. **Expected output:**
   ```
   Starting secret manager application...
   Retrieving secret: your-secret-name
   Current DB Time: 2025-08-05 12:34:56
   ```

---

## GitHub Actions Workflow (`access-secrets.yml`)

This workflow demonstrates how to fetch secrets from AWS Secrets Manager in a CI/CD pipeline using OIDC authentication.

### Key Steps

1. **Checkout Code:**  
   Uses `actions/checkout` to clone the repository.

2. **Configure AWS Credentials:**  
   Uses `aws-actions/configure-aws-credentials` with OIDC to assume an IAM role (`GHA_SecretReader`) that has permissions to read secrets.

3. **Install AWS CLI:**  
   Installs the AWS CLI if not already available on the runner.

4. **Fetch Secret:**  
   Uses the AWS CLI to retrieve the secret and saves it to `secret.json`. Also sets it as a workflow output.

5. **Use the Secret:**  
   Parses the secret using `jq` and demonstrates how to use the credentials in subsequent steps.

### Example Workflow Trigger

- On push to `main` branch
- Manually via workflow dispatch

### Customization

- Update the `role-to-assume` and `aws-region` fields to match your AWS setup.
- Change `SECRET_NAME` to your actual secret name in AWS Secrets Manager.

---

## Security Notes

- **Never hardcode secrets** in your code or workflows.
- Use IAM roles with least privilege for GitHub Actions.
- Rotate secrets regularly in AWS Secrets Manager.

---

## References

- [AWS Secrets Manager Documentation](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html)
- [GitHub Actions: Configure AWS Credentials](https://github.com/aws-actions/configure-aws-credentials)
- [boto3 Documentation](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)
- [pymysql Documentation](https://pymysql.readthedocs.io/en/latest/)

---

##
