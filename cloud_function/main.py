import google.cloud.logging
from flask import Request

client = google.cloud.logging.Client()
client.setup_logging()

def hello_world(request: Request):
    print("Hello log from Python Cloud Function")
    return "Hello World"