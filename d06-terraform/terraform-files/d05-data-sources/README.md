# Data Sources 
_______________________________________________________________________________

Run this command to install the Terraform providers declared 
in `f01_providers.tf`
```bash
terraform init
```
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

When prompted, type `yes` and press Enter.
_______________________________________________________________________________
