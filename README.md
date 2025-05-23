# ADT-Evaluation

This repository contains the solution to the ADT challenge, focused on implementing infrastructure as code using Terraform on Google Cloud Platform (GCP).
Key aspects such as multi-environment management, authentication, cloud function deployment, and monitoring are addressed.

---

## Project Structure
```text
├── cloud_function/ # Cloud Function source code
├── modules/ # Reusable Terraform modules
├── terraform.tfstate.d/ # Terraform state per workspace
├── main.tf # Main Terraform configuration
├── variables.tf # Variable definitions
├── outputs.tf # Terraform outputs
├── providers.tf # Provider configuration
├── locals.tf # Local variables
├── terraform.tfvars # Variable values
└── README.md # Project documentation
`````

## Deployment

### Initialize Terraform:
terraform init

### Create and select workspaces:
terraform workspace new dev
terraform workspace new rr
terraform workspace select dev

### Apply the configuration:
terraform apply

### GCP Authentication
To authenticate with GCP and allow Terraform to manage resources:
gcloud auth application-default login

Este comando configura las credenciales de aplicación predeterminadas, necesarias para que Terraform interactúe con GCP.

## Monitoring and Logging
Monitoring and logging have been integrated using GCP Cloud Monitoring and Logging to track application health and performance.
This includes creating custom dashboards and integrating with Cloud Functions.

## Testing
Retrieve the deployed function’s URL:
gcloud functions describe hello-function --region=us-central1 --format='value(httpsTrigger.url)'

Make an HTTP request:
curl https://<URL_DE_LA_FUNCIÓN>

## Notes
Make sure the GCP SDK is installed and you're properly authenticated before running Terraform commands.

Terraform workspaces allow isolated management of multiple environments (e.g., dev, rr).

If the function requires permissions, be sure to assign the roles/cloudfunctions.invoker role to the appropriate principal.