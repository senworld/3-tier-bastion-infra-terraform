# AWS 3-Tier Architecture with Bastion Host

This repository contains the Terraform code to deploy a highly available, secure 3-tier architecture on AWS. The architecture includes a bastion host for secure access, an AWS Application Load Balancer (ALB) in the public subnet for handling public traffic, NGINX servers in the private subnet as reverse proxies, application servers in the private subnet, an RDS instance for the database layer, a NAT Gateway for outbound internet access from the private subnets, and secure key management for accessing servers. The private keys for the NGINX, application, and CI/CD servers are accessible only from the bastion host, and the private key for the bastion host is stored locally inside the Terraform working folder.

![Architecture Diagram](./asset/arch.svg)

## Table of Contents
- [Overview](#overview)
- [Architecture Components](#architecture-components)
- [Key Management](#key-management)
- [Prerequisites](#prerequisites)
- [Terraform Setup](#terraform-setup)
  - [Initialization](#initialization)
  - [Planning and Deployment](#planning-and-deployment)
  - [Teardown](#teardown)
- [Modules](#modules)
- [Variables](#variables)
- [Outputs](#outputs)

## Overview

This deployment utilizes Terraform to provision the following:
- A Virtual Private Cloud (VPC) with public and private subnets across multiple availability zones.
- A bastion host in a public subnet for SSH access to private instances.
- An AWS Application Load Balancer (ALB) in the public subnet to route traffic to the NGINX reverse proxy servers.
- NGINX reverse proxy servers in private subnets that route traffic to the application tier.
- Application servers in private subnets, isolated from public internet access.
- A NAT Gateway for internet access for instances in private subnets.
- A Relational Database Service (RDS) instance in a private subnet.
- Integration with GitHub for CI/CD to automate infrastructure changes and application deployment.
- Private keys management, restricting access to the private key for the NGINX, application, and CI/CD servers only via the bastion host.

## Architecture Components

1. **VPC and Subnets**:
   - A custom VPC with CIDR `192.168.0.0/16`.
   - Public subnets for the bastion host, AWS ALB, and NAT Gateway.
   - Private subnets for NGINX reverse proxies, application servers, and RDS, isolated from the internet but with outbound access through the NAT Gateway.

2. **Bastion Host**:
   - Deployed in a public subnet.
   - Accessible only via SSH from allowed IPs, providing secure access to instances in private subnets.
   - Holds the private keys to access the NGINX, application, and CI/CD servers.

3. **AWS ALB and NGINX Reverse Proxy**:
   - The ALB sits in the public subnet and routes public traffic to NGINX reverse proxies in private subnets.
   - NGINX servers act as reverse proxies and load balancers for the application servers.

4. **Application Servers**:
   - Deployed across multiple private subnets for high availability.
   - Scalable EC2 instances with auto-scaling enabled.

5. **NAT Gateway**:
   - Deployed in a public subnet to allow outbound internet access for instances in private subnets.
   - Provides internet access for downloading packages, updates, and connecting to external services.

6. **RDS Database**:
   - A MySQL RDS instance deployed in a private subnet.
   - Secured by Security Groups and NACLs, accessible only from the application servers.

7. **Security**:
   - Security Groups and NACLs to control inbound and outbound traffic at the subnet and instance level.
   - No direct internet access to private subnets; all communication is routed via the bastion host, ALB, or NAT Gateway.

## Key Management

The architecture implements secure key management as follows:
- **Bastion Host Key**: 
  - The private key for accessing the bastion host is stored locally within the Terraform working folder.
  
- **Private Keys for NGINX, Application, and CI/CD Servers**:
  - The private keys for the NGINX, application, and CI/CD servers exist only on the bastion host. 
  - To access these servers, you must first SSH into the bastion host and use the corresponding private key stored there.

This setup enhances security by limiting direct access to sensitive infrastructure and ensuring that the private keys remain isolated on the bastion server.

## Prerequisites

Before you begin, ensure that you have the following:
- AWS account with appropriate permissions for VPC, EC2, RDS, and IAM.
- [Terraform](https://www.terraform.io/downloads.html) version 1.0 or higher installed.
- [AWS CLI](https://aws.amazon.com/cli/) configured with credentials and default region.
- A key pair for SSH access to the bastion host.

## Terraform Setup

### Initialization

1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/your-repo/aws-3-tier-bastion.git
   cd aws-3-tier-bastion
   ```

2. Initialize Terraform to download the necessary providers and modules:
   ```bash
   terraform init
   ```

### Planning and Deployment

1. Review the Terraform execution plan:
   ```bash
   terraform plan
   ```

   This will display the actions Terraform will take to create your infrastructure. Review the output carefully before proceeding.

2. Apply the Terraform configuration to deploy the infrastructure:
   ```bash
   terraform apply
   ```

   Confirm the action, and Terraform will create all resources in AWS.

### Teardown

To destroy all resources and clean up your AWS account:
```bash
terraform destroy
```

This command will remove all the infrastructure resources provisioned by Terraform.

## Modules

The architecture uses modular Terraform code to improve reusability and organization. The following core modules are used:

- **VPC Module**: 
  - Provisions the VPC, subnets, route tables, and network interfaces.
  
- **EC2 Module**:
  - Manages the bastion host and application servers (auto-scaling group).
  
- **RDS Module**:
  - Configures the RDS instance, including parameter groups and subnet groups.

- **ALB and NGINX Module**:
  - Sets up the AWS ALB in the public subnet and NGINX reverse proxies in private subnets.

- **NAT Gateway Module**:
  -  Provisions the NAT Gateway for internet access to private subnets.
  
- **Security Groups and NACL Module**:
  - Configures security groups and NACLs to control inbound/outbound traffic.

- **CI/CD Integration**:
  - Includes integration with GitHub Actions or other CI tools to automatically deploy infrastructure changes.

## Variables

The following variables are used to customize the deployment. You can update these values in the `terraform.tfvars` file:

- **AWS Region**: 
  - `region`: AWS region where resources will be deployed (e.g., `us-east-1`).
  
- **VPC and Subnet Configuration**:
  - `vpc_cidr`: The CIDR block for the VPC.
  - `public_subnets`: List of public subnet CIDRs.
  - `private_subnets`: List of private subnet CIDRs.
  
- **Instance Settings**:
  - `instance_type`: Type of EC2 instances for the app servers (e.g., `t3.micro`).
  - `desired_capacity`: Number of app instances to start with in the auto-scaling group.

For a full list of input variables, refer to the `vars.tf` file.

## Outputs

After deployment, Terraform provides the following outputs:
- **Bastion Host Public IP**: The public IP address to SSH into the bastion host.
- **Bastion Host Private Key**: The private key to access Bastion Host.
- **ALB DNS**: The DNS name of the AWS ALB.
