import 'package:flutter/material.dart';

class PostTitle extends StatelessWidget {
  final String title;

  const PostTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: const ListTile(
        title: Text(
          'Surya Natha',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        subtitle: Text('Denpasar, Bali', style: TextStyle(color: Colors.grey)),
        leading: CircleAvatar(
          backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
        ),
      ),
    );
  }
}
