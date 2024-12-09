import 'package:flutter/material.dart';
import 'package:myapp/views/moment/widgets/search_item.dart';

class SearchItemScrollable extends StatelessWidget {
  const SearchItemScrollable({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(30, (index) => const SearchItem());
    return SingleChildScrollView(
      child: Column(
        children: items,
      ),
    );
  }
}
