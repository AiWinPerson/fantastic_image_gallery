import 'package:flutter/material.dart';

import '../util/color_set.dart';

class ImageClip extends StatelessWidget {
  const ImageClip({super.key,required this.assetPath});
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorSet.transparent,
        borderRadius: BorderRadius.circular(5),
      ),
      clipBehavior: Clip.hardEdge,
      child: Image.asset(assetPath,fit: BoxFit.fill,),
    );
  }
}
