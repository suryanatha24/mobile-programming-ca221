import 'package:flutter/material.dart';
import 'package:myapp/resources/dimentions.dart';
import 'package:myapp/widgets/post_action.dart';
import 'package:myapp/widgets/post_title.dart';

import '../models/moment.dart';
import '../pages/create_comment_page.dart';

class PostItem extends StatefulWidget {
  const PostItem({
    super.key,
    required this.moment,
  });

  final Moment moment;

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  int commentCount = 0;

  @override
  void initState() {
    super.initState();
    commentCount = widget.moment.commentCount;
  }

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
          image: DecorationImage(
            image: NetworkImage(widget.moment.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PostTitle(
              creator: widget.moment.creator,
              location: widget.moment.location,
            ),
            Padding(
              padding: const EdgeInsets.all(smallSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      PostAction(
                        icon: 'assets/icons/fi-br-heart.svg',
                        label: widget.moment.likeCount.toString(),
                      ),
                      PostAction(
                        icon: 'assets/icons/fi-br-comment.svg',
                        label: commentCount.toString(),
                        onPressed: () async {
                          // Navigasi ke halaman CreateCommentPage dan menerima data
                          final result = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CreateCommentPage(),
                            ),
                          );

                          // Jika komentar dikirim, tambahkan jumlah komentar
                          if (result != null && result['comment'] != null) {
                            setState(() {
                              commentCount++;
                            });
                          }
                        },
                      ),
                      PostAction(
                        icon: 'assets/icons/fi-br-bookmark.svg',
                        label: widget.moment.bookmarkCount.toString(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: largeSize, bottom: mediumSize),
                    child: Text(
                      widget.moment.caption,
                      style: const TextStyle(
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
