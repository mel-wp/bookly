from connection import get_connection


def insert_books():

    conn = get_connection()

    cursor = conn.cursor()


    books = [

        (
            "Amor, Teoricamente",
            "Ali Hazelwood",
            2023,
            "Romance",
            "Uma história de romance no mundo acadêmico.",
            "imagem",
            "Disponível"
        ),


        (
            "A Hipótese do Amor",
            "Ali Hazelwood",
            2021,
            "Romance",
            "Uma pesquisadora entra em uma situação inesperada.",
            "imagem",
            "Disponível"
        ),

    ]


    cursor.executemany("""
    INSERT INTO books
    (
    title,
    author,
    year,
    category,
    description,
    image,
    status
    )

    VALUES(?,?,?,?,?,?,?)

    """, books)


    conn.commit()

    conn.close()



if __name__ == "__main__":
    insert_books()