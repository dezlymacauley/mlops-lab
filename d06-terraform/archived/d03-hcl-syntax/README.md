
_______________________________________________________________________________

Create a `setup_name.tf` file
_______________________________________________________________________________

initialize the Terraform in the project. 
```bash
terraform init
```

Also re-run this command if you ever update the `providers` section of your 
terraform file then you should re-run this command to let Terraform know
about the changes.
_______________________________________________________________________________

Load the the environment variables from the `.env` file

```bash
source .env
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
terraform apply
```

Type `yes` into the prompt and press Enter
```
Enter a value: yes
```
_______________________________________________________________________________

To destroy the infastructure
```bash
terraform destroy
```
_______________________________________________________________________________
