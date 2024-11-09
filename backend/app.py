# backend/app.py

from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

@app.route('/api/message', methods=['GET'])
def get_message():
    return jsonify({"message": "Hello from the Flask Backend!"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)