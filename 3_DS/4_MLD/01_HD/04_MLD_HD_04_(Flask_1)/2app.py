from flask import Flask, request, render_template

app = Flask(__name__)

@app.route("/", methods=["GET","POST"])
def home():
    if request.method == "GET":
        return render_template("index.html")
    if request.method == "POST":
        h = int(request.form.get("h"))
        w = int(request.form.get("w"))
        result = h**2/w
        return render_template("index.html", result=result)
    
if __name__ == "__main__"
    app.run(host="0.0.0.0", debug=True)
