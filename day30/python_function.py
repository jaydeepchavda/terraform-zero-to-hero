def lambda_handler(event, context):
    name = event["name"]

    return {
        "message": f"Hello {name}"
    }