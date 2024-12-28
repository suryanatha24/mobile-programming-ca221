import 'dart:convert';

class Moment {
  String? id;
  String? creatorId;
  String? creatorUsername;
  String? creatorFullname;
  DateTime momentDate;
  String caption;
  String location;
  double? longitude;
  double? latitude;
  String imageUrl;
  int totalLikes;
  int totalComments;
  int totalBookmarks;
  late DateTime createdAt;
  late DateTime lastUpdatedAt;

  Moment({
    this.id,
    this.creatorId,
    this.creatorUsername,
    this.creatorFullname,
    required this.momentDate,
    required this.caption,
    required this.location,
    this.longitude,
    this.latitude,
    required this.imageUrl,
    this.totalLikes = 0,
    this.totalComments = 0,
    this.totalBookmarks = 0,
    DateTime? createdAt,
    DateTime? lastUpdatedAt,
  }) {
    this.createdAt = createdAt ?? DateTime.now();
    this.lastUpdatedAt = lastUpdatedAt ?? DateTime.now();
  }

  Moment copyWith({
    String? id,
    String? creatorId,
    String? creatorUsername,
    String? creatorFullname,
    DateTime? momentDate,
    String? caption,
    String? location,
    double? longitude,
    double? latitude,
    String? imageUrl,
    bool? isActive,
    int? totalLikes,
    int? totalComments,
    int? totalBookmarks,
    DateTime? createdAt,
    DateTime? lastUpdatedAt,
  }) =>
      Moment(
        id: id ?? this.id,
        creatorId: creatorId ?? this.creatorId,
        creatorUsername: creatorUsername ?? this.creatorUsername,
        creatorFullname: creatorFullname ?? this.creatorFullname,
        momentDate: momentDate ?? this.momentDate,
        caption: caption ?? this.caption,
        location: location ?? this.location,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        imageUrl: imageUrl ?? this.imageUrl,
        totalLikes: totalLikes ?? this.totalLikes,
        totalComments: totalComments ?? this.totalComments,
        totalBookmarks: totalBookmarks ?? this.totalBookmarks,
        createdAt: createdAt ?? this.createdAt,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      );

  factory Moment.fromJson(String str) => Moment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Moment.fromMap(Map<String, dynamic> json) => Moment(
        id: json["id"],
        creatorId: json["creatorId"],
        creatorUsername: json["creatorUsername"],
        creatorFullname: json["creatorFullname"],
        momentDate: DateTime.parse(json["momentDate"]),
        caption: json["caption"],
        location: json["location"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        imageUrl: json["imageUrl"],
        totalLikes: json["totalLikes"],
        totalComments: json["totalComments"],
        totalBookmarks: json["totalBookmarks"],
        createdAt: DateTime.parse(json["createdAt"]),
        lastUpdatedAt: DateTime.parse(json["lastUpdatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "creatorId": creatorId,
        "creatorUsername": creatorUsername,
        "creatorFullname": creatorFullname,
        "momentDate": momentDate.toIso8601String(),
        "caption": caption,
        "location": location,
        "longitude": longitude,
        "latitude": latitude,
        "imageUrl": imageUrl,
        "totalLikes": totalLikes,
        "totalComments": totalComments,
        "totalBookmarks": totalBookmarks,
        "createdAt": createdAt.toIso8601String(),
        "lastUpdatedAt": lastUpdatedAt.toIso8601String(),
      };
}
