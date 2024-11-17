class Moment {
  String id;
  DateTime momentDate;
  String creator;
  String location;
  String imageUrl;
  String caption;
  int likeCount;
  int commentCount;
  int bookmarkCount;

  Moment({
    required this.id,
    required this.momentDate,
    required this.creator,
    required this.location,
    required this.imageUrl,
    required this.caption,
    this.likeCount = 0,
    this.commentCount = 0,
    this.bookmarkCount = 0,
  });
}
