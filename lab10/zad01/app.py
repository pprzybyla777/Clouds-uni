from flask import Flask

app = Flask(__name__)


@app.route('/')
def hello():
    return "GOODBYE WRLD!!!\n"


if __name__ == '__main__':
    print("Starting app...")
    app.run(host='0.0.0.0', port=8080)