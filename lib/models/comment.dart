class Comment {
  String id;
  String momentId;
  String creator;
  String content;
  DateTime createdAt;

  Comment(
      {required this.id,
      required this.momentId,
      required this.creator,
      required this.content,
      required this.createdAt});
}
