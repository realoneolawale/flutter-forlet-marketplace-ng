class LoginResponseDto {
  final String username;
  final String firstName;
  final String lastName;
  final String token;
  final String refreshToken;
  final String avatar;

  LoginResponseDto({
    this.username = '',
    this.firstName = '',
    this.lastName = '',
    this.token = '',
    this.refreshToken = '',
    this.avatar = '',
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      token: json['token'],
      refreshToken: json['refreshToken'],
      avatar: json['avatar'],
    );
  }
}
