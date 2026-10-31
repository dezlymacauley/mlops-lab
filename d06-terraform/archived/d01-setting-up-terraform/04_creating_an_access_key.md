# Creating an access key
_______________________________________________________________________________

1. Login to your IAM user account.
2. Go to the `IAM` service
3. On the left, there is a sidebar with a section titled `Access Management`.
4. Click tab that says `IAM Users`
5. Click the name of you IAM user.
6. Click `Security Credentials`
7. Scroll down to the `Access keys` section and click on `Create access key`
8. For the use case, select `Command Line Interface (CLI)`
_______________________________________________________________________________

Create a `.gitignore` file

```bash
touch .gitignore 
```
_______________________________________________________________________________

Add this to the file
```bash
.env*
!.env.example
```
_______________________________________________________________________________

Set up the following environment variables:

Add this to the `.env` file:

```env
export AWS_ACCESS_KEY_ID="value"
export AWS_SECRET_ACCESS_KEY="value"
export AWS_DEFAULT_REGION="value"
```
Replace `value` with the actual values

### Never show these values is public.
_______________________________________________________________________________

Then run 
```bash
source .env
```
_______________________________________________________________________________

To confirm that you are logged in using the correct account, 
run this command:
```bash
aws sts get-caller-identity
```
_______________________________________________________________________________
