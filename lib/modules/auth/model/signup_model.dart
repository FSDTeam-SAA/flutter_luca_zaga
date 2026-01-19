class SignupModel {
  final String name;
  final String email;
  final String phone;
  final String confirmPassword;
  final String password;

  SignupModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'confirmPassword': confirmPassword
    };
  }
}
