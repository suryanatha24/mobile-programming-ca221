import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/views/moment/widgets/post_item.dart';

import '../bloc/moment_bloc.dart';
import 'moment_entry_page.dart';

class MomentPage extends StatelessWidget {
  const MomentPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MomentBloc, MomentState>(
      listenWhen: (previous, current) => current is MomentActionState,
      buildWhen: (previous, current) => current is! MomentActionState,
      listener: (context, state) {
        if (state is MomentNavigateToAddActionState) {
          Navigator.pushNamed(context, MomentEntryPage.routeName);
        } else if (state is MomentNavigateToUpdateActionState) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Update Moment'),
                content:
                    const Text('Are you sure you want to update this moment?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(
                        context,
                        MomentEntryPage.routeName,
                        arguments: state.momentId,
                      );
                    },
                    child: const Text('Sure'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        } else if (state is MomentNavigateToDeleteActionState) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Delete Moment'),
                content:
                    const Text('Are you sure you want to delete this moment?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      context
                          .read<MomentBloc>()
                          .add(MomentDeleteEvent(state.momentId));
                      Navigator.of(context).pop();
                    },
                    child: const Text('Sure'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        } else if (state is MomentAddedSuccessActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Moment added successfully!')),
          );
          context.read<MomentBloc>().add(MomentGetEvent());
        } else if (state is MomentUpdatedSuccessActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Moment updated successfully!')),
          );
          context.read<MomentBloc>().add(MomentGetEvent());
        } else if (state is MomentDeletedSuccessActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Moment deleted successfully!')),
          );
          context.read<MomentBloc>().add(MomentGetEvent());
        } else if (state is MomentAddedErrorActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add moment')),
          );
          context.read<MomentBloc>().add(MomentGetEvent());
        } else if (state is MomentUpdatedErrorActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update moment')),
          );
          context.read<MomentBloc>().add(MomentGetEvent());
        } else if (state is MomentDeletedErrorActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to delete moment')),
          );
          context.read<MomentBloc>().add(MomentGetEvent());
        }
        if (state is MomentNavigateBackActionState) {
          Navigator.pop(context);
          context.read<MomentBloc>().add(MomentGetEvent());
        }
      },
      builder: (context, state) {
        if (state is MomentGetSuccessState) {
          return SingleChildScrollView(
            child: Column(
              children: state.moments
                  .map(
                    (momentItem) => PostItem(moment: momentItem),
                  )
                  .toList(),
            ),
          );
        } else if (state is MomentLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container();
      },
    );
  }
}
