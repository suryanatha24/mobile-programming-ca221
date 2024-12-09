import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/comment.dart';
import 'package:myapp/views/comment/pages/create_comment.dart';
import 'package:faker/faker.dart' as faker;
import 'package:nanoid2/nanoid2.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({
    super.key, 
    required this.momentId
    });
  final String momentId;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  List<Comment> comments = [];
  final _faker = faker.Faker();
  final _dateFormat = DateFormat('dd MMM yyyy');

  @override
  void initState() {
    super.initState();
    comments = List.generate(
      2,
      (index) => Comment(
        id: nanoid(),
        momentId: widget.momentId,
        createdAt: _faker.date.dateTime(),
        creator: _faker.person.name(),
        comment: _faker.lorem.sentence(),
      ),
    );
  }

  void _saveComment (Comment newComment) {
    final existingComment = getCommentById(newComment.id);
    if (existingComment == null) {
      setState(() {
        comments.add(newComment);
      });
    } else {
      setState(() {
        comments[comments.indexOf(existingComment)] = newComment;
      });
    }
  }
  void onUpdate(String commentId) {
    final selectedComment = comments.firstWhere((comment) => comment.id == commentId);
    showDialog(context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Update Comment'),
        content: const Text('Are you sure you want to update this comment?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Update'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return CreateComment(
                  onSaved: _saveComment,
                  selectedComment: selectedComment
                );
              }));
            },
          ),
        ]
      );
    });
  }

  void onDelete(String commentId) {
    final selectedComment = getCommentById(commentId);
    showDialog(context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete Comment'),
        content: const Text('Are you sure you want to delete this comment?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                comments.remove(selectedComment);
              });
            },
          ),
        ]
      );
    });
  }

  Comment? getCommentById(String commentId) {
    return comments.firstWhereOrNull((comment) => comment.id == commentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: comments.map((comment) => ListTile(
            title: Text(comment.creator),
            subtitle: Text(comment.comment),
            leading: const CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150')
            ),
            trailing: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Text(_dateFormat.format(comment.createdAt)), 
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'Edit') {
                      onUpdate(comment.id);
                    } else if (value == 'Delete') {
                      onDelete(comment.id);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'Edit',
                      child: Text('Edit')
                    ),
                    const PopupMenuItem(
                      value: 'Delete',
                      child: Text('Delete')
                    )
                  ],
                ),
              ]
            ),
          )).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return CreateComment(
              onSaved: _saveComment
            );
          }));
        },
        child: const Icon(Icons.comment),
      ),
    );
  }
}

// Text(_dateFormat.format(comment.createdAt))