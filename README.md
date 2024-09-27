# Module for AWS S3 resource management

## Terraform AWS S3 Bucket Setup

This Terraform configuration creates an AWS S3 bucket with a unique name using a random ID generator. The bucket is tagged with a name and environment variables.

## Prerequisites

Before you begin, ensure you have the following installed:

1. **Terraform**: Follow the [official installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli) to install Terraform.
2. **AWS CLI**: Install the AWS CLI by following the [installation instructions](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).
3. **AWS Account**: You need an AWS account to create resources.
4. **AWS Credentials**: Configure your AWS credentials using `aws configure` command.

## Configuration

1. **Clone the Repository**: Clone the repository containing this Terraform configuration.
    ```sh
    git clone <repository-url>
    cd <repository-directory>
    ```

2. **Set Up Environment Variables**: Create a `terraform.tfvars` file to define the required variables.
    ```plaintext
    environment     = "dev"
    s3_bucket_name  = "my-terraform-state-bucket"
    ```

3. **Initialize Terraform**: Initialize the Terraform working directory.
    ```sh
    terraform init
    ```

4. **Plan the Infrastructure**: Generate and review the execution plan.
    ```sh
    terraform plan
    ```

5. **Apply the Configuration**: Apply the configuration to create the resources.
    ```sh
    terraform apply
    ```

## Code Explanation

### random_id Resource

```hcl
resource "random_id" "bucket_id" {
  byte_length = 6
}
```

- **random_id**: Generates a random ID with a byte length of 6.

### aws_s3_bucket Resource

```hcl
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "tf-backend-${var.environment}-${random_id.bucket_id.hex}"

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name        = var.s3_bucket_name
    Environment = var.environment
  }
}
```

- **aws_s3_bucket**: Creates an S3 bucket with a unique name using the random ID and environment variable.
- **lifecycle**: The [`prevent_destroy`](command:_github.copilot.openSymbolFromReferences?%5B%22%22%2C%5B%7B%22uri%22%3A%7B%22scheme%22%3A%22file%22%2C%22authority%22%3A%22%22%2C%22path%22%3A%22%2Fworkspaces%2Fterraform-aws-s3%2Fmain.tf%22%2C%22query%22%3A%22%22%2C%22fragment%22%3A%22%22%7D%2C%22pos%22%3A%7B%22line%22%3A8%2C%22character%22%3A4%7D%7D%5D%2C%224447764e-5d3f-4f0c-9f26-059af4c8028d%22%5D "Go to definition") attribute is set to [`false`](command:_github.copilot.openSymbolFromReferences?%5B%22%22%2C%5B%7B%22uri%22%3A%7B%22scheme%22%3A%22file%22%2C%22authority%22%3A%22%22%2C%22path%22%3A%22%2Fworkspaces%2Fterraform-aws-s3%2Fmain.tf%22%2C%22query%22%3A%22%22%2C%22fragment%22%3A%22%22%7D%2C%22pos%22%3A%7B%22line%22%3A8%2C%22character%22%3A22%7D%7D%5D%2C%224447764e-5d3f-4f0c-9f26-059af4c8028d%22%5D "Go to definition"), allowing the bucket to be destroyed.
- **tags**: Tags the bucket with a name and environment.

## Clean Up

To destroy the created resources, run:
```sh
terraform destroy
```

## Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs/index.html)
- [AWS S3 Documentation](https://docs.aws.amazon.com/s3/index.html)

---

## How to refer the GitHub based module to create resources

To refer to a GitHub module to create an S3 bucket in your Terraform configuration, follow these steps:

1. **Identify the GitHub Repository**: Ensure you have the URL of the GitHub repository containing the Terraform module.

2. **Define the Module in Your Terraform Configuration**: Use the `module` block to refer to the GitHub repository.

### Example Directory Structure
```
.create_s3
├── main.tf
```

### Example 

main.tf

 in Root Directory
```hcl
provider "aws" {
  region = "us-west-2"
}

module "s3_bucket" {
  source          = "git::https://github.com/username/repo.git//path/to/module"
  environment     = "dev"
  s3_bucket_name  = "my-terraform-state-bucket"
}
```

### Steps to Use the Module

1. **Initialize Terraform**: Initialize the Terraform working directory.
    ```sh
    terraform init
    ```

2. **Plan the Infrastructure**: Generate and review the execution plan.
    ```sh
    terraform plan
    ```

3. **Apply the Configuration**: Apply the configuration to create the resources.
    ```sh
    terraform apply
    ```

### Explanation

- **source**: Specifies the GitHub repository URL. The `//path/to/module` part is optional and used if the module is in a subdirectory.
- **environment** and **s3_bucket_name**: These are variables defined in the module that you need to pass values for.

---

## Methods to configure AWS CLI
You can configure AWS credentials using the AWS CLI in several ways:

1. **Using `aws configure` Command**:
    ```sh
    aws configure
    ```
    This command will prompt you to enter your AWS Access Key ID, Secret Access Key, region, and output format.

2. **Environment Variables**:
    Set the following environment variables:
    ```sh
    export AWS_ACCESS_KEY_ID=your_access_key_id
    export AWS_SECRET_ACCESS_KEY=your_secret_access_key
    export AWS_DEFAULT_REGION=your_region
    ```

3. **Shared Credentials File**:
    Add your credentials to the `~/.aws/credentials` file:
    ```plaintext
    [default]
    aws_access_key_id = your_access_key_id
    aws_secret_access_key = your_secret_access_key
    ```

4. **Config File**:
    Add your configuration to the `~/.aws/config` file:
    ```plaintext
    [default]
    region = your_region
    output = json
    ```

5. **IAM Roles for EC2**:
    If running on an EC2 instance, you can assign an IAM role to the instance with the necessary permissions.

6. **AWS CLI Named Profiles**:
    You can create multiple profiles in the `~/.aws/credentials` and `~/.aws/config` files:
    ```plaintext
    [profile_name]
    aws_access_key_id = your_access_key_id
    aws_secret_access_key = your_secret_access_key
    ```

    Use the profile with:
    ```sh
    aws configure --profile profile_name
    ```

7. **AWS SSO (Single Sign-On)**:
    Configure AWS SSO with:
    ```sh
    aws configure sso
    ```
