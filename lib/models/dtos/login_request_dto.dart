class LoginRequestDto {
  final String username;
  final String password;

  LoginRequestDto({
    this.username = '',
    this.password = '',
  });

  factory LoginRequestDto.fromJson(Map<String, dynamic> json) {
    return LoginRequestDto(
      username: json['username'],
      password: json['password'],
    );
  }
}
