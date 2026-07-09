from connection import get_connection


def create_tables():

    conn = get_connection()

    cursor = conn.cursor()


    cursor.execute("""
    CREATE TABLE IF NOT EXISTS users(

        id INTEGER PRIMARY KEY AUTOINCREMENT,

        name TEXT NOT NULL,

        email TEXT UNIQUE NOT NULL,

        password TEXT NOT NULL

    )
    """)



    cursor.execute("""
    CREATE TABLE IF NOT EXISTS books(

        id INTEGER PRIMARY KEY AUTOINCREMENT,

        title TEXT NOT NULL,

        author TEXT NOT NULL,

        year INTEGER,

        category TEXT,

        description TEXT,

        image TEXT,

        status TEXT DEFAULT 'Disponível'

    )
    """)



    cursor.execute("""
    CREATE TABLE IF NOT EXISTS loans(

        id INTEGER PRIMARY KEY AUTOINCREMENT,

        user_id INTEGER,

        book_id INTEGER,

        request_date TEXT,

        status TEXT,

        FOREIGN KEY(user_id)
        REFERENCES users(id),

        FOREIGN KEY(book_id)
        REFERENCES books(id)

    )
    """)



    conn.commit()

    conn.close()



if __name__ == "__main__":
    create_tables()