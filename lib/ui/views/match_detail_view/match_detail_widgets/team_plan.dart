import 'package:flutter/material.dart';
import 'package:al_karama_app/ui/shared/utils.dart';

class TeamPlane extends StatelessWidget {
  final String plan;
  const TeamPlane({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(1),
      height: screenWidth(0.70),
      child: Image.network(
        plan,
        width: screenWidth(1),
        height: screenWidth(0.70),
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) {
          return SizedBox();
        },
      ),
    );
  }
}
