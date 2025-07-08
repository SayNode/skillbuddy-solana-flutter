import 'package:flutter/material.dart';

import '../../../../service/theme_service.dart';
import '../../../../theme/theme.dart';

class RoundedSquareAvatar extends StatelessWidget {
  const RoundedSquareAvatar({
    required this.size,
    required this.imageUrl,
    super.key,
  });
  final double size;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;

    return ClipRRect(
      borderRadius:
          BorderRadius.circular(8), // Adjust the border radius as needed
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color:
              skillBuddyTheme.grey, // You can set a background color if needed
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
