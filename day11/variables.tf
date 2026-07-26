variable "project_name" {
  default = "Project ALPHA Resource"
}



variable  "instance_type" {
  
  default = "t2.micro"
  validation {

    condition = length(var.instance_type)  >= 2 && length(var.instance_type) <= 20
    error_message = "instance type must be  between 2 and 20 character"

  }
  validation {
    condition = can(regex("^t[2-3]\\.",var.instance_type))
    error_message = "Instance type must start with t2 and t3"
  }
}


variable  "backup_name" {
  
  default = "daily_backup"
  
  validation {
    condition = endswith(var.backup_name , "_backup")
    error_message = "Backup name must end with '_backup'"
  }
}

variable credentials {
  default = "xyz123"
  sensitive= true
}