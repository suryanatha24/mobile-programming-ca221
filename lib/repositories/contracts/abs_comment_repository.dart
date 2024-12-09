import 'package:myapp/models/comment.dart';

abstract class AbsCommentRepository {
  Future<void> addComment(Comment comment);
  Future<void> updateComment(Comment comment);
  Future<void> deleteComment(String commentId);
  Future<List<Comment>> getCommentsByMomentId(String momentId);
  Future<Comment?> getCommentById(String commentId);
}