/*
  ABOUT: Block Syntax

  The code in a Terraform file is structured into blocks

  This is the syntax of a block:

  "configuration_type" "type_of_resource" "reference_name" {
    name_of_key = expression or value
    name_of_key = expression or value
    name_of_key = expression or value
  }

  You can refer to block by using this syntax:
  "type_of_resource"."reference_name"

*/
