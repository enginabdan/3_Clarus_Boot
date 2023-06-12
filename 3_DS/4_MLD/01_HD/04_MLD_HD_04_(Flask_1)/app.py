from flask import Flask, request, render_template

app = Flask(__name__)

@app.route("/")
def home():
    return f"""
    <h1>Welcome to my homepage, Engin</h1>
    Flask Server is UP
    """

@app.route("/api")
def api():
    name = request.args.get("name")
    age = int(request.args.get("age"))
    return f"Your name is {name} and your age is {age}"

@app.route("/<num>")
def number(num):
    return f"You entered {num}"

@app.route("/<name>")
def hello(name):
    return f"hello {name.title()}"