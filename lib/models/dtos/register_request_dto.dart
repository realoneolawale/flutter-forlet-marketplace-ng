class RegisterRequestDto {
  late String? firstName;
  late String? lastName;
  late String? email;
  late String? gender;
  late String? phone;
  late String? houseNumber;
  late String? streetName;
  late String? areaName;
  late String? address;
  late String? avatar;
  late int? stateId;
  late int? lgaId;
  late String? password;
  late String? confirmPassword;

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
