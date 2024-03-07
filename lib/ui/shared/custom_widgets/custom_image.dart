import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;
  final double width, height;
  final BoxFit boxFit;
  const CustomImage(
      {super.key,
      required this.imageUrl,
      required this.width,
      required this.height,
      required this.boxFit});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageUrl,
      width: width,
      fit: boxFit,
      height: height,
    );
  }
}
