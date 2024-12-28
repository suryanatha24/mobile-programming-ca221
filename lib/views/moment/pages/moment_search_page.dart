import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/resources/dimentions.dart';
import 'package:myapp/views/moment/bloc/moment_bloc.dart';

import '../widgets/post_item_square.dart';
import '../widgets/search_and_filter.dart';

class MomentSearchPage extends StatelessWidget {
  const MomentSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final moments = context.read<MomentBloc>().moments;
    return Padding(
      padding: const EdgeInsets.all(largeSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SearchAndFilter(
            onSubmit: (keyword) {},
          ),
          const SizedBox(
            height: largeSize,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => PostItemSquare(
                momentId: moments[index].id!,
                imageUrl: moments[index].imageUrl,
              ),
              itemCount: moments.length,
            ),
          ),
        ],
      ),
    );
  }
}
