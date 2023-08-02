# Portfolio of Prasad Suman Mohan - Cloud DevOps Engineer

![image](https://github.com/sumanprasad007/website-hosting-using-terraform-on-aws-cloud/assets/55047333/eea1205e-2f40-47dc-92da-cd77d94a3e06)

This is my personal portfolio showcasing my skills as a Cloud DevOps Engineer. It includes details about my background, projects, testimonials, and contact information.

## Table of Contents

- [Portfolio](https://linktr.ee/sumanprasad007)
- [About Me](#about-me)
- [Reviews](#reviews)
- [Cloud Native Projects](#cloud-native-projects)
- [Contact Me](#contact-me)

# Hosting a Static Website Using Terraform on AWS S3

This README provides a step-by-step guide on how to use Terraform to host a static website on AWS S3. We'll cover the process of creating an S3 bucket, configuring it for static website hosting, and deploying the website content.

## Prerequisites

Before getting started, ensure you have the following prerequisites:

- An AWS account with appropriate permissions to create S3 resources.
- Terraform installed on your local machine. If you don't have it installed, you can download it from the [Terraform website](https://www.terraform.io/downloads.html).

## Steps

1. **Create a Terraform Configuration File**

   Create a new directory for your Terraform configuration and create a file named `main.tf` inside it. This file will contain the Terraform code to define the S3 bucket and its configuration.

2. **Configure Provider**

   In the `main.tf` file, define the AWS provider and region. Add the following code:

   ```hcl
   provider "aws" {
     region = "us-east-1" # Change this to your desired AWS region
   }
   ```

3. **Create S3 Bucket**  

Define the S3 bucket resource in the main.tf file. The bucket name should be globally unique. Add the following code:

        ```
        resource "aws_s3_bucket" "website_bucket" {
        bucket = "your-unique-bucket-name" # Replace with your desired bucket name
        acl    = "public-read"
        website {
            index_document = "index.html"
            error_document = "error.html"
        }
        }
        ```

4. **Enable Static Website Hosting**
Add the following code to enable static website hosting for the S3 bucket:
    ```
    resource "aws_s3_bucket_policy" "website_policy" {
    bucket = aws_s3_bucket.website_bucket.bucket
    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Sid = "PublicReadGetObject",
            Effect = "Allow",
            Principal = "*",
            Action = ["s3:GetObject"],
            Resource = [
            "${aws_s3_bucket.website_bucket.arn}/*",
            ],
        },
        ],
    })
    }

    ```

5. **Upload Website Content**
Place your website files (e.g., HTML, CSS, JS) in a directory named website within your Terraform configuration directory. Then, use the aws_s3_bucket_object resource to upload these files to the S3 bucket:

    ```
    resource "aws_s3_bucket_object" "website_files" {
    bucket = aws_s3_bucket.website_bucket.bucket
    acl    = "public-read"
    key    = "website/"
    source = "website/"
    }

    ```

6. **Initialize and Apply Terraform**
Run the following commands to initialize and apply the Terraform configuration:

    ```
    terraform init
    terraform apply

    ```
Terraform will display a plan showing the resources to be created or modified. Type yes to proceed with the changes.

7. **Access Your Website**
After the Terraform apply is complete, you can access your static website using the endpoint provided by AWS S3. The endpoint will be displayed in the Terraform output. It should look like

    ```
    http://your-unique-bucket-name.s3-website-us-east-1.amazonaws.com.
    ```
8. **Clean the resources**
To clean up the resources created by Terraform, run the following command:

    ```
    terraform destroy --auto-approve
    ```
9. **Conclusion**

Congratulations! You've successfully hosted a static website on AWS S3 using Terraform. Remember to always clean up your resources to avoid unnecessary costs.

For more information about Terraform and AWS S3, check out the official documentation:

Terraform Documentation
AWS S3 Developer Guide

## About Me

Hey there, I'm Prasad Suman Mohan, a Cloud DevOps Engineer. I am passionate about cloud computing and DevOps. As a Cloud DevOps Engineer, I have extensive experience in designing and implementing cloud solutions using a variety of DevOps tools, including Kubernetes, Docker, ArgoCD, GitLab, Jenkins, Prometheus, and Grafana. I take pride in my work and have successfully completed various projects, helping clients optimize costs, improve system performance, and ensure reliability.

## Reviews

Check out what my clients have to say about my work:

- ⭐⭐⭐⭐⭐ "Prasad's expertise in cloud computing and DevOps is unparalleled. He provided valuable insights and solutions for our project, and we couldn't be happier with the results." - John Doe, CEO at Example Corp

## Cloud Native Projects

Explore some of the cloud native projects I have worked on:

- **Project: Kubernetes in the Cloud**
  A scalable and robust Kubernetes setup in the cloud, leveraging the power of microservices architecture and Helm for deployment.

<!-- Add more cloud native projects as needed -->

## Contact Me

If you have any questions, collaboration opportunities, or just want to say hello, feel free to reach out to me:

- Email: prasad.suman.mohan@example.com
- Portfolio: [My Portfolio](https://linktr.ee/sumanprasad007)
- LinkedIn: [My LinkedIn Profile](https://www.linkedin.com/in/sumanprasad007)
- GitHub: [My GitHub Profile](https://github.com/sumanprasad007)

---

_&copy; 2023 Prasad Suman Mohan | All rights reserved._
