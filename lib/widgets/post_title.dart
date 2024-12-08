import 'package:flutter/material.dart';

class PostTitle extends StatelessWidget {
  const PostTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text(
        'Surya Natha',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
      ),
      subtitle: Text('Denpasar, Bali', style: TextStyle(color: Colors.white54)),
      leading: CircleAvatar(
        backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
      ),
    );
  }
}
