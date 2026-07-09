from flask import Blueprint, jsonify, request

from database.connection import get_connection


loans = Blueprint(
    "loans",
    __name__
)


@loans.route("/loans", methods=["POST"])
def create_loan():

    data = request.json

    user_id = data["user_id"]
    book_id = data["book_id"]


    conn = get_connection()

    cursor = conn.cursor()


    cursor.execute("""
        INSERT INTO loans
        (
            user_id,
            book_id,
            request_date,
            status
        )

        VALUES
        (
            ?,
            ?,
            datetime('now'),
            'Pendente'
        )

    """,
    (
        user_id,
        book_id
    ))


    cursor.execute("""
        UPDATE books
        SET status = 'Emprestado'
        WHERE id = ?
    """,
    (book_id,))


    conn.commit()

    conn.close()


    return jsonify({
        "message": "Empréstimo solicitado com sucesso!"
    })