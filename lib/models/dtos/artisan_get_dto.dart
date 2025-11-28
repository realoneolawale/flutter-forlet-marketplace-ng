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
