import 'package:aplikasi01/models/comment.dart';
import 'package:aplikasi01/pages/comment_entry_page.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart' as faker;
import 'package:intl/intl.dart';
import 'package:nanoid2/nanoid2.dart';
import 'package:aplikasi01/resources/colors.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key, required this.momentId});
  final String momentId;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> _comments = [];
  final _faker = faker.Faker();
  final _dateFormat = DateFormat('dd MMM yyy');

  @override
  void initState() {
    super.initState();
    _comments = List.generate(
      5,
      (index) => Comment(
        id: nanoid(),
        creator: _faker.person.name(),
        content: _faker.lorem.sentence(),
        createdAt: _faker.date.dateTime(),
        momentId: widget.momentId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _comments
              .map((comment) => ListTile(
                    title: Text(comment.creator),
                    subtitle: Text(comment.content),
                    leading: const CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://i.pravatar.cc/150'),
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (String value) {
                        if (value == 'edit') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CommentEntryPage(
                                selectedComment: comment,
                                onSaved: (updatedComment) {
                                  setState(() {
                                    final index = _comments.indexWhere(
                                        (c) => c.id == updatedComment.id);
                                    if (index != -1) {
                                      _comments[index] = updatedComment;
                                    }
                                  });
                                },
                              ),
                            ),
                          );
                        } else if (value == 'delete') {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Comment'),
                              content: const Text(
                                  'Are you sure you want to delete this comment?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _comments.removeWhere(
                                          (c) => c.id == comment.id);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ],
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_dateFormat.format(comment.createdAt)),
                          const Icon(Icons.more_vert, color: primaryColor),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return CommentEntryPage(
              onSaved: (newComment) {
                setState(() {
                  _comments.add(newComment);
                });
              },
              selectedComment: null, //buat komen baru
            );
          }));
        },
        child: const Icon(Icons.comment),
      ),
    );
  }
}
