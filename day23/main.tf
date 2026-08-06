resource "aws_instance" "web" {

    ami = data.aws_ami.ubuntu.id

    instance_type = "t3.micro"

    subnet_id = var.public_subnet

    vpc_security_group_ids = [

        aws_security_group.web.id

    ]

    iam_instance_profile = aws_iam_instance_profile.profile.name

    user_data = file("userdata.sh")

}