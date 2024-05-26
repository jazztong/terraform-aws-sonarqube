# Terraform AWS SonarQube

This repository demonstrates the setup of SonarQube on AWS using Terraform. It includes modules for setting up SonarQube applications and PostgreSQL RDS instances.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0.0
- AWS CLI configured with appropriate credentials
- An AWS account

## Installation

1. **Clone the Repository:**

   ```sh
   git clone https://github.com/jazztong/terraform-aws-sonarqube.git
   cd terraform-aws-sonarqube
   ```

2. **Initialize Terraform:**
   ```sh
   terraform init
   ```

## Usage

1. **Configure Variables:**
   Update the `variables.tf` file in each module with your desired values.

2. **Plan and Apply:**
   ```sh
   terraform plan
   terraform apply
   ```

## Documentation

Generate module documentation using `terraform-docs`:

1. **Install terraform-docs:**

   ```sh
   brew install terraform-docs
   ```

2. **Generate Documentation:**
   ```sh
   terraform-docs markdown table . > README.md
   ```

## File Structure

```
terraform-aws-sonarqube/
│
├── .gitignore
├── .terraform-docs.yml
├── LICENSE
├── Makefile
├── README.md
│
├── app/
│   ├── sonarqube-app/
│   └── sonarqube-db/
│
└── modules/
    ├── rds-postgresql/
    └── sonarqube-app/
```

## Contributing

1. **Fork the repository.**
2. **Create a new branch:**
   ```sh
   git checkout -b feature-name
   ```
3. **Make your changes and commit them:**
   ```sh
   git commit -m "Description of changes"
   ```
4. **Push to the branch:**
   ```sh
   git push origin feature-name
   ```
5. **Create a pull request.**

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
