/*

  data "data_source_type" "data_source_name" {
     value = "identifier"
  }

*/

data "aws_caller_identity" "current" {
  value = "identifier"
}

data "aws_region" "current" {

}
