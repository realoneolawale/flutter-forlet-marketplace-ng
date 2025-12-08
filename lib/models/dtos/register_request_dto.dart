class RegisterRequestDto {
  late final String? firstName;
  late final String? lastName;
  late final String? email;
  late final String? gender;
  late final String? phone;
  late final String? houseNumber;
  late final String? streetName;
  late final String? areaName;
  late final String? address;
  late final String? avatar;
  late final int? stateId;
  late final int? lgaId;
  late final String? password;
  late final String? confirmPassword;

  RegisterRequestDto({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.houseNumber,
    this.streetName,
    this.areaName,
    this.address,
    this.avatar,
    this.stateId,
    this.lgaId,
    this.password,
    this.confirmPassword,
  });

  factory RegisterRequestDto.fromJson(Map<String, dynamic> json) {
    return RegisterRequestDto(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      gender: json['gender'],
      phone: json['phone'],
      houseNumber: json['houseNumber'],
      streetName: json['streetName'],
      areaName: json['areaName'],
      address: json['address'],
      avatar: json['avatar'],
      stateId: json['stateId'],
      lgaId: json['lgaId'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': gender,
      'phone': phone,
      'houseNumber': houseNumber,
      'streetName': streetName,
      'areaName': areaName,
      'address': address,
      'avatar': avatar,
      'stateId': stateId,
      'lgaId': lgaId,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
