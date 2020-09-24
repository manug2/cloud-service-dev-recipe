from flask import Flask
import os
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!!  Calc Service is running at: http://" + os.getenv('CALC_SERVICE_IP')