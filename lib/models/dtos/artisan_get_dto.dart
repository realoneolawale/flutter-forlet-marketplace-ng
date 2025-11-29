class ArtisanGetDto {
  final int? artisanId;
  final String? artisanName;
  final String? artisanImage;
  final String? artisanshipName;
  final String? artisanAddress;
  final bool? isArtisanLive;
  final String? artisanJoinDate;
  final String? artisanshipDescription;

  ArtisanGetDto({
    this.artisanId,
    this.artisanName,
    this.artisanImage,
    this.artisanshipName,
    this.artisanAddress,
    this.isArtisanLive,
    this.artisanJoinDate,
    this.artisanshipDescription,
  });

  factory ArtisanGetDto.fromJson(Map<String, dynamic> json) {
    return ArtisanGetDto(
      artisanId: json['artisanId'],
      artisanName: json['artisanName'],
      artisanImage: json['artisanImage'],
      artisanshipName: json['artisanshipName'],
      artisanAddress: json['artisanAddress'],
      isArtisanLive: json['isArtisanLive'],
      artisanJoinDate: json['artisanJoinDate'],
      artisanshipDescription: json['artisanshipDescription'],
    );
  }
}

class ArtisanFullGetDto {
  final int? artisanId;
  final String? clientId;
  final String? artisanName;
  final String? artisanAddress;
  final String? artisanAvatar;
  final String? artisanshipName;
  final String? artisanshipDescription;
  final String? artisanCreatedDate;
  final List<ArtisanServiceDto> artisanServices;
  final List<ArtisanRequestDto> artisanRequests;
  final List<ArtisanImageDto> artisanImages;

  ArtisanFullGetDto({
    this.artisanId,
    this.clientId,
    this.artisanName,
    this.artisanAddress,
    this.artisanAvatar,
    this.artisanshipName,
    this.artisanshipDescription,
    this.artisanCreatedDate,
    required this.artisanServices,
    required this.artisanRequests,
    required this.artisanImages,
  });

  factory ArtisanFullGetDto.fromJson(Map<String, dynamic> json) {
    return ArtisanFullGetDto(
      artisanId: _toInt(json['artisanId']),
      clientId: json['clientId'],
      artisanName: json['artisanName'],
      artisanAddress: json['artisanAddress'],
      artisanAvatar: json['artisanAvatar'],
      artisanshipName: json['artisanshipName'],
      artisanshipDescription: json['artisanDescription'],
      artisanCreatedDate: json['artisanCreatedDate'],
      artisanServices: (json['artisanServices'] as List? ?? [])
          .map((x) => ArtisanServiceDto.fromJson(x))
          .toList(),
      artisanRequests: (json['artisanRequests'] as List? ?? [])
          .map((x) => ArtisanRequestDto.fromJson(x))
          .toList(),
      artisanImages: (json['artisanImages'] as List? ?? [])
          .map((x) => ArtisanImageDto.fromJson(x))
          .toList(),
    );
  }
}

class ArtisanServiceDto {
  final int? artisanId;
  final String? services;
  final double price;

  ArtisanServiceDto({
    this.artisanId,
    this.services,
    required this.price,
  });

  factory ArtisanServiceDto.fromJson(Map<String, dynamic> json) {
    return ArtisanServiceDto(
      artisanId: _toInt(json['artisanId']),
      services: json['services'],
      price: _toDouble(json['price']),
    );
  }
}

class ArtisanRequestDto {
  final int? id;
  final String? clientId;
  final int? artisanId;
  final int? workAmount;
  final String? reference;
  final String? comment;
  final int? rating;
  final String? completionDate;

  ArtisanRequestDto({
    this.id,
    this.clientId,
    this.artisanId,
    this.workAmount,
    this.reference,
    this.comment,
    this.rating,
    this.completionDate,
  });

  factory ArtisanRequestDto.fromJson(Map<String, dynamic> json) {
    return ArtisanRequestDto(
      id: _toInt(json['id']),
      clientId: json['clientId'],
      artisanId: _toInt(json['artisanId']),
      workAmount: _toInt(json['workAmount']),
      reference: json['reference'],
      comment: json['comment'],
      rating: _toInt(json['rating']),
      completionDate: json['completionDate'],
    );
  }
}

class ArtisanImageDto {
  final int? artisanId;
  final String? artisanImageName;
  final String? artisanImageUrl;

  ArtisanImageDto({
    this.artisanId,
    this.artisanImageName,
    this.artisanImageUrl,
  });

  factory ArtisanImageDto.fromJson(Map<String, dynamic> json) {
    return ArtisanImageDto(
      artisanId: _toInt(json['artisanId']),
      artisanImageName: json['artisanImageName'],
      artisanImageUrl: json['artisanImageUrl'],
    );
  }
}

// Helper converters
int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  return int.tryParse(value.toString());
}

double _toDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0.0;
}
