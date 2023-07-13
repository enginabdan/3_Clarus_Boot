from flask import Flask, request, render_template

import pandas as pd
import joblib

model = joblib.load(open("model2.pkl","rb"))

app = Flask(__name__)

@app.route("/")
def home():
    return "flask server is running"


if __name__ == "__main__":
    app.run(debug=True, port=81)