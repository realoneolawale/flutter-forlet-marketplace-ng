class ArtisanshipGetDto {
  final int? id;
  final String? artisanshipName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ArtisanshipGetDto && id == other.id;

  @override
  int get hashCode => id.hashCode;

  ArtisanshipGetDto({
    this.id,
    this.artisanshipName,
  });

  factory ArtisanshipGetDto.fromJson(Map<String, dynamic> json) {
    return ArtisanshipGetDto(
      id: json['id'],
      artisanshipName: json['artisanshipName'],
    );
  }
}
