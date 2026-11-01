# AWS VPC
_______________________________________________________________________________

Run this command to install the Terraform providers declared 
in `f01_terraform_providers.tf`
```bash
terraform init
```

#### Note:
- If you update the `f01_terraform_providers.tf` file,
you should run `terraform init` again.
_______________________________________________________________________________

To check what actions Terraform will perform (without applying those actions
to your infastructure), run this command.

```bash
terraform plan
```
_______________________________________________________________________________

To update your infastructure, run this command
```bash
terraform apply -auto-approve
```
_______________________________________________________________________________

To destroy the infastructure
```bash
terraform destroy
```
_______________________________________________________________________________
