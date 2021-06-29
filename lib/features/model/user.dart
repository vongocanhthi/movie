class User {
  String updatedAt;
  String email;
  String fullName;
  Object gender;
  Object birthday;
  String id;
  String accessToken;
  Object password;
  Object facebookId;
  Object googleId;
  Object createdAt;

  User(
      {this.updatedAt,
      this.email,
      this.fullName,
      this.gender,
      this.birthday,
      this.id,
      this.accessToken,
      this.password,
      this.facebookId,
      this.googleId,
      this.createdAt});

  factory User.fromJson(Map<String, dynamic> json) => User(
        updatedAt: json["updatedAt"],
        email: json["email"],
        fullName: json["fullName"],
        gender: json["gender"],
        birthday: json["birthday"],
        id: json["id"],
        accessToken: json["accessToken"],
        password: json["password"],
        facebookId: json["facebookId"],
        googleId: json["googleId"],
        createdAt: json["createdAt"],
      );
}
