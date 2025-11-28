class LgasGetDto {
  final int id;
  final String lgaName;

  LgasGetDto({
    this.id = 0,
    this.lgaName = '',
  });

  factory LgasGetDto.fromJson(Map<String, dynamic> json) {
    return LgasGetDto(
      id: json['id'],
      lgaName: json['lgaName'],
    );
  }
}
