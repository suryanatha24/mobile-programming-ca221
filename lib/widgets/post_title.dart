import 'package:flutter/material.dart';

class PostTitle extends StatelessWidget {
  const PostTitle({
    super.key,
    required this.creator,
    required this.location,
  });

  final String creator;
  final String location;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        creator,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
      ),
      subtitle: Text(location, style: const TextStyle(color: Colors.white54)),
      leading: const CircleAvatar(
        backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
      ),
    );
  }
}
