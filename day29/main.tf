resource "aws_lambda_function" "s3_processor" {
  function_name = "s3-file-processor"

  runtime = "python3.12"
  handler = "lambda_function.lambda_handler"

  role = aws_iam_role.lambda_execution.arn

  filename = "lambda_function.zip"
}


resource "aws_lambda_function" "s3_processor" {
  function_name = "s3-file-processor"

  runtime = "python3.12"
  handler = "lambda_function.lambda_handler"

  role = aws_iam_role.lambda_execution.arn

  filename = "lambda_function.zip"
}


resource "aws_s3_bucket_notification" "lambda_trigger" {
  bucket = aws_s3_bucket.uploads.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_processor.arn
    events              = ["s3:ObjectCreated:*"]
  }
}


resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"

  function_name = aws_lambda_function.s3_processor.function_name
  principal     = "s3.amazonaws.com"

  source_arn = aws_s3_bucket.uploads.arn
}