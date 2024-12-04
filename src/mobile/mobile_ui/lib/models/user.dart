class User {
  String firstName;
  String lastName;
  String email;
  // final String encodedPassword;
  String phoneNum;
  // final int activeSince;
  String profileImagePath;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    // required this.encodedPassword,
    required this.phoneNum,
    required this.profileImagePath,
  });


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNum: json['phone'],
      profileImagePath: json['profile_url']
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phoneNum,
      'profile_url': profileImagePath
    };
  }
}