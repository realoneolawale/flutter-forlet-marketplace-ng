class HomeTypeDto {
  late final int id;
  late final String name;

  HomeTypeDto({required this.id, required this.name});

  factory HomeTypeDto.fromJson(Map<String, dynamic> json) {
    return HomeTypeDto(
      id: json['id'],
      name: json['artisanshipName'] ??
          json['housingTypeName'] ??
          json['communityTypeName'] ??
          json['saleTypeName'] ??
          json['generalServiceName'] ??
          json['jobTypeName'] ??
          json['discussionTypeName'] ??
          json['personalTypeName'] ??
          json['gigTypeName'] ??
          '',
    );
  }
}
