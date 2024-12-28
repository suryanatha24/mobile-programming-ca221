import 'package:flutter/material.dart';
import 'package:myapp/core/resources/dimentions.dart';

class PostItemSquare extends StatelessWidget {
  const PostItemSquare({
    super.key,
    required this.momentId,
    required this.imageUrl,
  });
  final String imageUrl;
  final String momentId;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: const EdgeInsets.all(smallSize),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(extraLargeSize),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
