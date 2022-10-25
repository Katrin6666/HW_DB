import psycopg2

#создание БД
def create_db(conn):
    with conn.cursor() as cur:
        cur.execute("""
        CREATE TABLE IF NOT EXISTS clients(
            client_id SERIAL PRIMARY KEY,
            name VARCHAR(40) NOT NULL,
            surname VARCHAR(50) NOT NULL,
            email VARCHAR(100) NOT NULL);
        """)

def phones(conn):
    with conn.cursor() as cur:
        cur.execute("""
        CREATE TABLE if not exists phones(
            phone_id SERIAL PRIMARY KEY,
            number VARCHAR(15),
            client_id INTEGER NOT NULL REFERENCES clients(client_id)
            );
        """)

def clear(conn):
    with conn.cursor() as cur:
        cur.execute("""
        DROP TABLE phones;
        DROP TABLE clients;
        """)

#2.добавить нового клиента
def add_new_client(conn, name, surname, email, phone=None):
    with conn.cursor() as cur:
        cur.execute("""
        INSERT INTO clients(name, surname, email) VALUES(%s,%s,%s) RETURNING client_id;
        """, (name, surname, email))
        client_id = cur.fetchone()
        if phone is not None:
            cur.execute("""
            INSERT INTO phones(number, client_id) VALUES (%s, %s) RETURNING phone_id;
            """, (phone, client_id))
            print(client_id[0], 'Новый клиент добавлен', name, phone)
        else:
            print(client_id[0], 'Новый клиент добавлен', name, '- тел. не указан')

#3.добавить телефон для существующего клиента
def add_phone(conn, phone, client_id):
    with conn.cursor() as cur:
        cur.execute("""
        INSERT INTO phones(number, client_id)
        VALUES (%s, %s) RETURNING phone_id;
        """, (phone, client_id))
        cur.execute("""
               SELECT name FROM clients WHERE client_id = client_id;
               """)
        name = cur.fetchall()[client_id-1][0]
    print('Номер', phone, 'добавлен клиенту', client_id, name)

#4.Функция, позволяющая изменить данные о клиенте
def change_client(conn, client_id, name=None, surname=None, email=None):
    if name is not None:
        with conn.cursor() as cur:
            cur.execute("""UPDATE clients SET name=%s 
            WHERE client_id = %s RETURNING client_id;
            """, (name, client_id))
            cur.fetchone()
    if surname is not None:
        with conn.cursor() as cur:
            cur.execute("""UPDATE clients SET surname=%s 
            WHERE client_id = %s RETURNING client_id;
            """, (surname, client_id))
            cur.fetchone()
    if email is not None:
        with conn.cursor() as cur:
            cur.execute("""UPDATE clients SET email=%s 
            WHERE client_id = %s RETURNING client_id;
            """, (email, client_id))
            cur.fetchone()
    print('Данные клиента', client_id, 'обновлены')

#5.Функция, позволяющая удалить телефон для существующего клиента
def delete_phone(conn, client_id, number):
    with conn.cursor() as cur:
        cur.execute("""
            DELETE FROM phones WHERE client_id=%s and number=%s;
            """, (client_id, number))
        cur.execute("""
            SELECT * FROM phones WHERE client_id=%s;
            """, (client_id,))
        print('Телефон', number, 'клиента', client_id, 'удален.', 'Оставшиеся телефоны клиента:', cur.fetchall()[0][1])

#6.Функция, позволяющая удалить существующего клиента
def delete_client(conn, client_id):
    with conn.cursor() as cur:
        cur.execute("""
                DELETE FROM phones WHERE client_id=%s;
                """, (client_id,))
        cur.execute("""
                DELETE FROM clients WHERE client_id=%s;
                """, (client_id,))
        conn.commit()
        print('Клиент', client_id, 'удален')

#7.Функция, позволяющая найти клиента по его данным (имени, фамилии, email-у или телефону)
def find_client(conn, name=None, surname=None, email=None, number=None):
    with conn.cursor() as cur:
        if number is not None:
            cur.execute("""
                    SELECT cl.client_id FROM clients cl
                    JOIN phones ph ON ph.client_id = cl.client_id
                    WHERE ph.number=%s;
                    """, (number,))
        else:
            cur.execute("""
                    SELECT client_id FROM clients 
                    WHERE name=%s OR surname=%s OR email=%s;
                    """, (name, surname, email))
        print('Найден клиент', cur.fetchone()[0])


with psycopg2.connect(database="sql_psyco", user="postgres", password="postgres") as conn:
    create_db(conn)
    phones(conn)
    add_new_client(conn, 'Илья', 'Петров', 'ilaja@gmail.com')
    add_new_client(conn, 'Вася', 'Петров', 'vasja@gmail.com', 79806665455)
    add_new_client(conn, 'Маша', 'Иванова', 'masha@gmail.com', 79996543355)
    add_phone(conn, 79806548587, 2)
    change_client(conn, 3, 'Ира')
    delete_phone(conn, 2, '79806665455')
    delete_client(conn, 1)
    find_client(conn, name=None, surname=None, email=None, number='79806548587')
    find_client(conn, name='Ира', surname=None, email=None, number=None)
    clear(conn)

conn.commit()
conn.close()