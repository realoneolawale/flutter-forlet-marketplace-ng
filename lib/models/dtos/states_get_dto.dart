class StateGetDto {
  final int id;
  final String stateName;

  StateGetDto({
    this.id = 0,
    this.stateName = '',
  });

  factory StateGetDto.fromJson(Map<String, dynamic> json) {
    return StateGetDto(
      id: json['id'],
      stateName: json['stateName'],
    );
  }
}
