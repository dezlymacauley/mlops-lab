# AWS Lambda
_______________________________________________________________________________

Search for the `Lamda` service
_______________________________________________________________________________

Click `Create an event function` and select `Use blueprint`
_______________________________________________________________________________

Select the following options:

Function name: `manually-created-lambda`

_______________________________________________________________________________

Add the following code

index.mjs
```javascript
console.log('Loading function');

export const handler = async (event, context) => {
    return "Hello, World"
};
```
_______________________________________________________________________________

Click `Create Event Function`
_______________________________________________________________________________

Click the `Configuration Tab`, then click `Permissions` on the sidebar

_______________________________________________________________________________

You should see a role name:
```
manually-created-lambda-role-prd88t1u 
```

#### Note:
- This was automatically created in the `IAM` service
_______________________________________________________________________________

This will also create a cloudwatch log in the `CloudWatch` service

_______________________________________________________________________________
