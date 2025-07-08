import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AvatarShimmerPlaceholder extends StatelessWidget {
  const AvatarShimmerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 110,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          //add border radius 12
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
