import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/dimentions.dart';
import 'package:flutter_application_1/widgets/post_action.dart';
import 'package:flutter_application_1/widgets/post_title.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: largeSize,
          vertical: mediumSize,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(extraLargeSize),
          image: const DecorationImage(
            // image: AssetImage('assets/images/moments_background_dark.png'),
            image: NetworkImage('https://picsum.photos/800/600?random=3'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PostTitle(),
            Padding(
              padding: EdgeInsets.all(smallSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      PostAction(
                        icon: 'assets/icons/fi-br-heart.svg',
                        label: '230',
                      ),
                      PostAction(
                        icon: 'assets/icons/fi-br-comment.svg',
                        label: '50',
                      ),
                      PostAction(
                        icon: 'assets/icons/fi-br-bookmark.svg',
                        label: '10',
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: largeSize, bottom: smallSize),
                    child: Text(
                      'This is an example of moment post',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
