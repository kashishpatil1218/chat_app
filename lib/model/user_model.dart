class UserModel {
  String? name, email, Image, phone, token;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.Image,
    required this.token});

  factory UserModel.fromMap(Map m1) {
    return UserModel(
        name: m1['name'],
        email: m1['email'],
        phone: m1['phone'],
        Image: m1['Image'],
        token: m1['token']);
  }

  Map<String, String?> toMap(UserModel user) {
    return {
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'Image': user.Image,
      'token': user.token,
    };
  }
}
