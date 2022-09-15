class User {
  int userType, status;
  String userName, phoneNo, password, email, userID;
  User({
    this.userID,
    this.userType,
    this.userName,
    this.status,
    this.password,
    this.phoneNo,
    this.email,
  });
  Map<String, dynamic> toMap() => {
        "userID": userID,
        "userType": userType,
        "status": status,
        "password": password,
        "phoneNo": phoneNo,
        "email": email,
        "userName": userName,
      };

  //to receive the data we need to pass it from Map to json
  //para recibir los datos necesitamos pasarlo de Map a json
  factory User.fromMap(Map<String, dynamic> json) => new User(
        userID: json["userID"],
        userType: int.parse(json["userType"]),
        userName: json["userName"],
        status: json["status"],
        password: json["password"],
        phoneNo: json["phoneNo"],
        email: json["email"],
      );
}
