class User {
  User({
    required this.firstName,
    required this.lastName,
    required this.uid,
  });
  final String firstName;
  final String lastName;
  final String uid;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json['firstName'],
        lastName: json['lastName'],
        uid: json['uid'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['uid'] = uid;
    return data;
  }
}
