#!/bin/bash

echo "Environment = ${environment}"

echo "Project = ${project}"

yum update -y
yum install nginx -y
systemctl enable nginx
systemctl start nginx