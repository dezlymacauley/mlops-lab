
Load your environment variables
```bash
source .env
```
_______________________________________________________________________________

After creating your `.tf` files, run this command
```bash
terraform init
```
_______________________________________________________________________________

To check if a `.tf` file is valid, Run these commands

```bash
terraform validate
```

Note: This only checks if the syntax is valid, 
it does not check for misconfigurations.
_______________________________________________________________________________

Use this command to view the changes that Terraform intends to make,
without applying those changes.
```bash
terraform plan
```
_______________________________________________________________________________

Use this command to view a list of resources that Terraform is managing
```bash
terraform state list
```
_______________________________________________________________________________

Use this command to apply your changes
```bash
terraform apply
```

## Name of bucket that was created
bucket_name = "example-bucket-cf5efada56f2"
_______________________________________________________________________________


Run this cmmand to see what Terraform will destroy,
without destroying your infastructure.
```bash
terraform plan -destroy
```
_______________________________________________________________________________

To destroy the infastructure
```bash
terraform destroy
```
_______________________________________________________________________________

Then run this command to confirm that everything has been deleted
```bash
terraform state list
```
_______________________________________________________________________________
