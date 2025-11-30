import 'home_type_dto.dart';

class HomeTypesListDto {
  final List<HomeTypeDto>? artisanshipTypes;
  final List<HomeTypeDto>? housingTypes;
  final List<HomeTypeDto>? communityTypes;
  final List<HomeTypeDto>? saleTypes;
  final List<HomeTypeDto>? generalServiceTypes;
  final List<HomeTypeDto>? jobTypes;
  final List<HomeTypeDto>? discussionTypes;
  final List<HomeTypeDto>? personalTypes;
  final List<HomeTypeDto>? gigTypes;

  HomeTypesListDto({
    this.artisanshipTypes = const [],
    this.housingTypes = const [],
    this.communityTypes = const [],
    this.saleTypes = const [],
    this.generalServiceTypes = const [],
    this.jobTypes = const [],
    this.discussionTypes = const [],
    this.personalTypes = const [],
    this.gigTypes = const [],
  });

  factory HomeTypesListDto.fromJson(Map<String, dynamic> json) {
    return HomeTypesListDto(
        artisanshipTypes: (json['artisanshipTypes'] as List? ?? [])
            .map((listJson) => HomeTypeDto.fromJson(listJson))
            .toList(),
        housingTypes: (json['housingTypes'] as List? ?? [])
            .map((listJson) => HomeTypeDto.fromJson(listJson))
            .toList(),
        communityTypes: (json['communityTypes'] as List? ?? [])
            .map((listJson) => HomeTypeDto.fromJson(listJson))
            .toList(),
        saleTypes: (json['saleTypes'] as List? ?? [])
            .map((listJson) => HomeTypeDto.fromJson(listJson))
            .toList(),
        generalServiceTypes: (json['generalServiceTypes'] as List? ?? [])
            .map((listJson) => HomeTypeDto.fromJson(listJson))
            .toList(),
        jobTypes: (json['jobTypes'] as List? ?? [])
            .map((listJson) => HomeTypeDto.fromJson(listJson))
            .toList(),
        discussionTypes: (json['discussionTypes'] as List? ?? [])
            .map((listJson) => HomeTypeDto.fromJson(listJson))
            .toList(),
        personalTypes: (json['personalTypes'] as List? ?? [])
            .map((listJson) => HomeTypeDto.fromJson(listJson))
            .toList(),
        gigTypes: (json['gigTypes'] as List? ?? [])
            .map((listJson) => HomeTypeDto.fromJson(listJson))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'artisanshipTypes': artisanshipTypes,
      'housingTypes': housingTypes,
      'communityTypes': communityTypes,
      'saleTypes': saleTypes,
      'generalServiceTypes': generalServiceTypes,
      'jobTypes': jobTypes,
      'discussionTypes': discussionTypes,
      'personalTypes': personalTypes,
      'gigTypes': gigTypes,
    };
  }
}
