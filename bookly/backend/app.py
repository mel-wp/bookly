from flask import Flask
from flask_cors import CORS

from routes.books import books
from routes.loans import loans


app = Flask(__name__)

CORS(app)


app.register_blueprint(books)
app.register_blueprint(loans)


if __name__ == "__main__":
    app.run(debug=True)