# Infrastructure as Code (Terraform)

This directory contains three Terraform modules that provision a simple AWS environment for learning/testing:

- `VPC`: Creates a basic public VPC with subnets and internet access
- `ec2-web-server`: Launches an EC2 instance with Apache HTTP server
- `S3-static-hosting`: Hosts a static website on S3 (public read)

---

## Module: VPC (`IAC/VPC`)

Provisioned resources:
- `aws_vpc.vpc`: CIDR `10.0.0.0/16`, tagged `my_vpc`
- `aws_internet_gateway.gateway`: IGW attached to the VPC
- `aws_route.route`: Default route `0.0.0.0/0` via IGW in the main route table
- `data.aws_availability_zones.available`: Discovers available AZs
- `aws_subnet.main` (count per AZ): Public subnets `10.0.<index>.0/24`, public IPs on launch

Inputs (see `variables.tf`):
- `region` (default: `us-east-1`)
- `access_key`, `secret_key` (credentials; see Security Notes)

Outputs: (none defined in `VPC` module)

Notes:
- Subnets are public (`map_public_ip_on_launch = true`) and route to the internet gateway.

---

## Module: EC2 Web Server (`IAC/ec2-web-server`)

Provisioned resources:
- `aws_security_group.web-server-sg`:
  - Ingress: TCP 80 from `0.0.0.0/0`
  - Egress: all protocols to `0.0.0.0/0`
- `aws_instance.web-server`:
  - AMI: `ami-08982f1c5bf93d976` (Amazon Linux 2)
  - Type: `t2.micro`
  - User data: installs and enables Apache (`httpd`) and writes a simple index page

Inputs (see `variables.tf`):
- `region` (default: `us-east-1`)
- `access_key`, `secret_key`

Outputs (see `output.tf`):
- `name`: Public IP address of the instance

Notes:
- The security group currently allows HTTP from anywhere. SSH is not opened.

---

## Module: S3 Static Hosting (`IAC/S3-static-hosting`)

Provisioned resources:
- `random_string.random`: Random suffix for unique bucket name
- `aws_s3_bucket.static_site_bucket`: S3 bucket with `force_destroy = true`
- `aws_s3_bucket_website_configuration.static_site_website`: Static website hosting
  - Index document: `index.html`
  - Error document: `error.html`
- `aws_s3_bucket_public_access_block.public_access_block`: Public access block settings disabled to permit public website access
- `aws_s3_object.upload_object`: Uploads files from local `HTML/` (or `html/`) folder to the bucket
- `aws_s3_bucket_policy.read_access_policy`: Grants public `s3:GetObject` to the bucket contents

Inputs (see `variables.tf`):
- `region` (default: `us-east-1`)
- `access_key`, `secret_key`

Outputs (see `output.tf`):
- `aws_s3_bucket_id`: Website endpoint URL (e.g., `http://<bucket-website-endpoint>`)

Notes:
- The static site files are expected under `IAC/S3-static-hosting/HTML/` in this repository.

---

## How to Use

From each module directory (`IAC/VPC`, `IAC/ec2-web-server`, `IAC/S3-static-hosting`):

```bash
terraform init
terraform plan 
terraform apply -auto-approve
```

- You can provide variables via a `terraform.tfvars` file or via `-var` flags. Example `terraform.tfvars`:

```hcl
region     = "us-east-1"
access_key = "<YOUR_ACCESS_KEY>"
secret_key = "<YOUR_SECRET_KEY>"
```

- To destroy resources:

```bash
terraform destroy -auto-approve
```

---

## Security Notes (Important)

- Do not commit AWS credentials. Prefer one of the following instead of plaintext variables:
  - Use an AWS named profile and configure the provider with the profile/region
  - Export `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and (optionally) `AWS_SESSION_TOKEN`
  - Use Terraform Cloud/Enterprise or a secrets manager to inject sensitive values
- The S3 website is publicly readable by design. Do not upload sensitive content.
- The EC2 security group allows inbound HTTP from anywhere. Lock down sources or place behind a load balancer as needed.
- Consider using an ALB/CloudFront + ACM for HTTPS, and S3 origin access control if you move from website hosting to CloudFront.

---

## Outputs Quick Reference

- EC2 Web Server: public IP exposed as output `name`
- S3 Static Hosting: bucket website endpoint exposed as output `aws_s3_bucket_id`

---

## Troubleshooting

- If uploads to S3 fail, verify the local `HTML/` folder and file names match what Terraform expects. On case-sensitive systems, ensure the path casing matches the configuration.
- If you see credential errors, confirm your AWS profile or environment variables are set, or provide variables via `terraform.tfvars` (do not commit this file).
- Ensure your selected AWS region supports the AMI ID used for the EC2 instance; update the AMI if needed.
