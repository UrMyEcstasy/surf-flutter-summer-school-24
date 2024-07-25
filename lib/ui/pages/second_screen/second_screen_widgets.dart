// second_screen_widgets.dart

import 'package:flutter/material.dart';

class PageViewItem extends StatelessWidget {
  final String image;
  const PageViewItem({
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        height: 600,
        width: 350,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
