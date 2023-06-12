from flask import Flask, request, render_template

app  = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def home():
if request.method == "GET":
return render_template("index.html")
if request.method == "POST":
h = int(request.form.get("h"))
w = int(request.form.get("w"))
result = h**2/w
return render_template("index.html",result=result)

@app.route("/api", methods=["GET", "POST"])
def api():
if request.method == "GET":
return "post your data as json format h:,w: "
if request.method == "POST":
h = int(request.json.get("h"))
w = int(request.json.get("w"))
result = h**2/w
return {"response":f"{result:.2f}"}

if __name__ == "__main__":
app.run(host="0.0.0.0", debug=True)