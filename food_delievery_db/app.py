from flask import Flask, jsonify, request
from flask_cors import CORS
import mysql.connector

def get_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Macbook@2023",
        database="food_delivery_db"
    )

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}}, supports_credentials=True)

@app.route('/cafes')
def get_cafes():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM cafes")
    cafes = cursor.fetchall()
    conn.close()
    return jsonify(cafes)

@app.route('/signup', methods=['POST'])
def signup():
    data = request.get_json()
    name = data.get('name')
    email = data.get('email')
    password = data.get('password')

    conn = get_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("INSERT INTO users (name, email, password) VALUES (%s, %s, %s)", (name, email, password))
        conn.commit()
        return jsonify({'status': 'success', 'message': 'User registered successfully'}), 200
    except mysql.connector.Error as err:
        return jsonify({'status': 'fail', 'message': str(err)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')

    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM users WHERE email = %s AND password = %s", (email, password))
    user = cursor.fetchone()
    cursor.close()
    conn.close()

    if user:
        return jsonify({'status': 'success', 'message': 'Login successful', 'user': user}), 200
    else:
        return jsonify({'status': 'fail', 'message': 'Invalid credentials'}), 401


# Add order and cart history routes
@app.route('/add-order', methods=['POST'])
def add_order():
    data = request.get_json()
    items = data.get('items')
    payment_method = data.get('paymentMethod')
    address = data.get('address')
    date = data.get('date')
    status = data.get('status')
    total = data.get('total')

    conn = get_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("""
            INSERT INTO orders (items, payment_method, address, date, status, total)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (str(items), payment_method, address, date, status, total))
        conn.commit()
        return jsonify({'status': 'success', 'message': 'Order saved'}), 200
    except mysql.connector.Error as err:
        return jsonify({'status': 'fail', 'message': str(err)}), 400
    finally:
        cursor.close()
        conn.close()

@app.route('/cart-history')
def get_order_history():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM orders ORDER BY date DESC")
    orders = cursor.fetchall()
    conn.close()
    return jsonify(orders)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5002)