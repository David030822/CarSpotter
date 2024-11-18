from flask import Flask, request, jsonify
from werkzeug.security import check_password_hash
from models.user_model import User,db


app = Flask(__name__)
  
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///carsproject.db'  
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)

@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route('/login', methods=['POST','GET'])

def login():

    email = None
    password = None
    if request.method == 'POST':
        return jsonify({"message": "Please send a POST request with your email and password"}),400
    if request.method == 'POST':
                
            if request.is_json:
                data = request.get_json()
                email = data.get('email')
                password = data.get('password')

                if not email or not password:
                    return jsonify({"message": "Email and password are required"}), 400

    if email and password:
        user = User.query.filter_by(email=email).first()
        if user and check_password_hash(user.password,password):
            return jsonify({"message": "Login successfull"}), 200
        return jsonify({"message":"Invalid login"}), 401
    else:
        return jsonify({"message": "Email and password are required"}),400

if __name__ == "__main__":
    app.run(debug=True)
