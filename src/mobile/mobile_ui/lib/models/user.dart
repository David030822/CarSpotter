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
}