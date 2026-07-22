
#!/bin/bash

echo "Hello Terraform"
yum update -y
yum install nginx -y
systemctl enable nginx
systemctl start nginx