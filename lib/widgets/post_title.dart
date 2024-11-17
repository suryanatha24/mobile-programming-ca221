import 'package:aplikasi01/models/moment.dart';
import 'package:flutter/material.dart';

class PostTitle extends StatelessWidget {
  const PostTitle({
    super.key,
    required this.moment,
    required this.onDelete,
    required this.onUpdate,
  });
  final Moment moment;
  final Function(String id) onDelete;
  final Function(String id) onUpdate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        moment.creator,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
      ),
      subtitle:
          Text(moment.location, style: const TextStyle(color: Colors.white54)),
      leading: const CircleAvatar(
        backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
      ),
      trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'Edit') {
              onUpdate(moment.id);
            } else if (value == 'Delete') {
              onDelete(moment.id);
            }
          },
          itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'Edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  value: 'Delete',
                  child: Text('Delete'),
                ),
              ],
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.5),
            child: const Icon(Icons.more_vert, color: Colors.white),
          )),
    );
  }
}
