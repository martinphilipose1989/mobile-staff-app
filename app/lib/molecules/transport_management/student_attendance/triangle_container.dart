import 'package:app/themes_setup.dart';
import 'package:flutter/material.dart';

class TriangleContainer extends StatelessWidget {
  const TriangleContainer({super.key, required this.isPresent});

  final bool isPresent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0, // No width for the triangle
      height: 10, // No height for the triangle
      margin: const EdgeInsets.symmetric(horizontal: 14.0),
      decoration: BoxDecoration(
        border: Border(
          left: const BorderSide(width: 12.0, color: Colors.transparent),
          bottom: BorderSide(
              width: 10.0,
              color: isPresent ? AppColors.success : AppColors.failure),
        ),
      ),
    );
  }
}
