import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/comment.dart';
import 'package:faker/faker.dart' as faker;
import 'package:nanoid2/nanoid2.dart';

import 'commment_entry_page.dart';

class CommentPage extends StatefulWidget {
  static const routeName = '/comments';
  const CommentPage({super.key, required this.momentId});
  final String momentId;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> _comments = [];
  final _faker = faker.Faker();
  final _dateFormat = DateFormat('dd MMM yyyy');

  @override
  void initState() {
    super.initState();
    _comments = List.generate(
      5,
      (index) => Comment(
        id: nanoid(),
        creatorUsername: _faker.person.name(),
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
                    title: Text(comment.creatorUsername.toString()),
                    subtitle: Text(comment.content),
                    leading: const CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://i.pravatar.cc/150'),
                    ),
                    trailing: Text(_dateFormat.format(comment.createdAt)),
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CommentEntryPage.routeName);
        },
        child: const Icon(Icons.comment),
      ),
    );
  }
}
