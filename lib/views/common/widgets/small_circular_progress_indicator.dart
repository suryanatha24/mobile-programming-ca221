import 'package:flutter/material.dart';

import '../../../core/resources/colors.dart';

class SmallCircularProgressIndicator extends StatelessWidget {
  final Color color;
  const SmallCircularProgressIndicator({
    this.color = primaryColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 4.0,
      ),
    );
  }
}
