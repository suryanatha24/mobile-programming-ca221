import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/views/moment/bloc/moment_bloc.dart';
import 'package:myapp/views/moment/pages/moment_entry_page.dart';
import 'package:myapp/views/moment/widgets/post_item.dart';

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
            builder: (context) => AlertDialog(
              title: const Text('Update Moment'),
              content: const Text('Are you sure you want to update this moment?'),
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
                    Navigator.pushNamed(context, MomentEntryPage.routeName, arguments: state.momentId);
                  },
                ),
              ],
            ),
          );
        } else if (state is MomentNavigateToDeleteActionState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Delete Moment'),
              content: const Text('Are you sure you want to delete this moment?'),
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
                    context.read<MomentBloc>().add(MomentDeleteEvent(state.momentId));
                  },
                ),
              ],
            ),
          );
        } else if (state is MomentAddedSuccessActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Moment Added Successfully'))
          );
          context.read<MomentBloc>().add(MomentGetEvent());
        } else if (state is MomentUpdatedSuccessActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Moment Updated Successfully'))
          );
          context.read<MomentBloc>().add(MomentGetEvent());
        } else if (state is MomentDeletedSuccessActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Moment Deleted Successfully'))
          );
          context.read<MomentBloc>().add(MomentGetEvent());
        } else if (state is MomentAddedErrorActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to Add Moment'))
          );
          context.read<MomentBloc>().add(MomentGetEvent());
        } else if (state is MomentUpdatedErrorActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to Update Moment'))
          );
          context.read<MomentBloc>().add(MomentGetEvent());
        } else if (state is MomentDeletedErrorActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to Delete Moment'))
          );
          context.read<MomentBloc>().add(MomentGetEvent());
        } if (state is MomentNavigateBackActionState) {
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
                  (momentItem) => PostItem(
                    moment: momentItem, 
                  )
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
