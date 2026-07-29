data "aws_caller_identity" "name"  { }

output "acount_id" {
     value = data.aws_caller_identity.name
 } 
