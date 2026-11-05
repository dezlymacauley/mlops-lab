locals {
  users_from_yaml = yamldecode(file("${path.module}/yaml-configs/user_roles.yaml")).users
}

output "users_from_yaml" {
  value = local.users_from_yaml
}

/*

  NOTE: This should be the output

  users_from_yaml = [
    {
      "roles" = [
        "readonly",
        "developer",
      ]
      "username" = "kevin"
    },
    {
      "roles" = [
        "admin",
        "auditor",
      ]
      "username" = "jane"
    },
    {
      "roles" = [
        "readonly",
      ]
      "username" = "ben"
    },
  ]

*/

#______________________________________________________________________________

# SECTION: Creating the users

resource "aws_iam_user" "users" {
  
}

#______________________________________________________________________________
