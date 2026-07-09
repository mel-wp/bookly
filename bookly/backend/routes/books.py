from flask import Blueprint, jsonify

from database.connection import get_connection


books = Blueprint(
    "books",
    __name__
)


@books.route("/books/<int:id>", methods=["GET"])
def get_book(id):

    conn = get_connection()

    cursor = conn.cursor()

    cursor.execute(
        "SELECT * FROM books WHERE id = ?",
        (id,)
    )

    book = cursor.fetchone()

    conn.close()


    if book:
        return jsonify(dict(book))


    return jsonify({
        "message": "Livro não encontrado"
    }), 404