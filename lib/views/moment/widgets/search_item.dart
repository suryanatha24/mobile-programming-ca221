import 'package:flutter/material.dart';
import 'package:myapp/core/resources/dimentions.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      margin: const EdgeInsets.symmetric(
        horizontal: largeSize,
        vertical: smallSize
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.symmetric(
                horizontal: mediumSize,
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
            ),
          ),
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.symmetric(
                horizontal: mediumSize,
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
            ),
          ),
        ],
      ),
    );
  }
}
