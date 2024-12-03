class User {
  final String firstName;
  final String lastName;
  final String email;
  // final String encodedPassword;
  final String phoneNum;
  // final int activeSince;
  final String profileImagePath;

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