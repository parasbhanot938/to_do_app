class UserModel {
  String id;
  String fullName;
  String email;

  UserModel({required this.fullName, required this.email, required this.id});

  Map<String, String> toMap() {
    return {
      'fullName': fullName,
      'id': id,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, String> map) {
    return UserModel(
      id: map['id'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
    );
  }
}