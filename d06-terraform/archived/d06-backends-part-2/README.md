Load your environment variables
```bash
source .env
```
_______________________________________________________________________________

The file `dev.s3.tfbackend` containst the settings for the terraform backend.

_______________________________________________________________________________

After creating your `.tf` files, run this command
```bash
terraform init \
    -backend-config="prod.s3.tfbackend" \
    -migrate-state
```
_______________________________________________________________________________

To create the infastructure
```bash
terraform apply
```
_______________________________________________________________________________

To destroy the infastructure
```bash
terraform destroy
```
_______________________________________________________________________________
