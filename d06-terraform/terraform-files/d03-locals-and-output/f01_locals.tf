/*
  ABOUT: `locals` and `output`

  The `locals` block is used to declare variables in Terraform

*/

locals {
  #____________________________________________________________________________

  # SECTION: 1 => Single Value Data Types

  # string: For storing text values
  project_name = "purple-rose"

  # number: For whole numbers (number without a decimal part) 
  # and floating point numbers (numbers with a decimal part)
  project_version = 1
  project_cost    = 19.99

  # bool: For storing the valued `true` or `false`
  is_production = false

  #____________________________________________________________________________

  # SECTION: 2 => Compound Data Types

  # tuple: An ordered collection elements.
  # The data type of each element in the tuple can be different.
  project_details = [
    "purple-rose",
    1,
    true
  ]

  # list: An ordered collection of elements.
  # The data type of each element in the list must be of the same data type.
  programming_languages = tolist([
    "Rust",
    "Go",
    "Python"
  ])

  # set: An ordered collection of elements.
  # The data type of each element in the list must be of the same data type.
  supported_regions = toset([
    "eu-north-1",
    "us-east-1",
    "eu-north-1"
  ])

  # map: A collection of key-value pairs where all values
  # have the same type.
  environment_urls = {
    development = "dev.example.com"
    staging     = "staging.example.com"
    production  = "example.com"
  }

  # object: A collection of named attributes that can
  # have different types.
  project_config = {
    name          = "purple-rose"
    version       = 1
    is_production = false
    languages     = ["Rust", "Python"]
  }
}
