/// Session returned after a successful OTP verification or email login.
///
/// Assumed payload (adjust when the API contract is final):
/// `{"data": {"token": "...", "name": "..."}}`.
class AuthResponseModel {
  const AuthResponseModel({required this.token, this.name});

  AuthResponseModel.fromJson(Map<String, dynamic> json)
    : token = json['token'] as String? ?? '',
      name = json['name'] as String?;

  final String token;
  final String? name;

  Map<String, dynamic> toJson() => {'token': token, 'name': name};
}
