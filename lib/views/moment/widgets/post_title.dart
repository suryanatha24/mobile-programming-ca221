import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/models/moments.dart';
import 'package:myapp/core/resources/colors.dart';
import 'package:myapp/views/moment/bloc/moment_bloc.dart';

class PostTitle extends StatelessWidget {
  const PostTitle({
    super.key,
    required this.moment,
    });

  final Moment moment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        moment.creator,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
      ),
      subtitle: Text(moment.location, style: const TextStyle(color: Colors.white54)),
      leading: const CircleAvatar(
        backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
      ),
      trailing: PopupMenuButton(
        onSelected: (value) {
          if (value == 'Edit') {
            context.read<MomentBloc>().add(MomentNavigateToUpdateEvent(moment.id));
          } else if (value == 'Delete') {
            context.read<MomentBloc>().add(MomentNavigateToDeleteEvent(moment.id));
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
        child: CircleAvatar(
          backgroundColor: primaryColor.withOpacity(0.5),
          child: const Icon(
            Icons.more_vert,
            color: Colors.white54)),

      ),
    );
  }
}
