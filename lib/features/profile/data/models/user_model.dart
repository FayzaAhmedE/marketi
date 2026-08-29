class UserModel {
  final String name;
  final String username;
  final String email;
  final String phone;
  final String? avatarUrl;

  const UserModel({
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      avatarUrl: json['avatarUrl'],
    );
  }
}
