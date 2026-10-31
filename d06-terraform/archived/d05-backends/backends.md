Backends
This is where Terraform stores its state file

- local = The state file is stored in the user's local machine
- Terraform cloud
- Third party remote backends: Amazon S3, Google cloud storage

You can only have one backend and that will be the single source of truth.

You need to run the `terraform init` command whenever you change backends.
