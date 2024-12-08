import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/post_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(30, (index) => const PostItem());
    return SingleChildScrollView(
      child: Column(
        children: items,
      ),
    );
  }
}
