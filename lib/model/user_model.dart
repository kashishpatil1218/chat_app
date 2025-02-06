class UserModel {
  String? name, email, Image, phone;
  bool isOnline;

  UserModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.Image,
      required this.isOnline});

  factory UserModel.fromMap(Map m1) {
    return UserModel(
        name: m1['name'],
        email: m1['email'],
        phone: m1['phone'],
        Image: m1['Image'],
        isOnline: m1['isOnline']);
  }

  Map<String, dynamic> toMap(UserModel user) {
    return {
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'Image': user.Image,
      'isOnline': user.isOnline,
    };
  }
}
