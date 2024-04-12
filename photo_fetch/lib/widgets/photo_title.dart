import 'package:flutter/material.dart';
import 'package:photo_fetch/resources/resources.dart';

class PhotoTitle extends StatelessWidget {
  final String title;
  const PhotoTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Padding(
        padding: const EdgeInsets.all(PaddingSizes.sm),
        child: Text(
          title,
          softWrap: true,
          style: AppStyles.photoTitleTextStyle,
        ),
      ),
    );
  }
}
