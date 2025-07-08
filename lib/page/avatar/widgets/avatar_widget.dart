import 'package:flutter/material.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import 'avatar_shimmer_placeholder.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    required this.avatar,
    required this.isSelected,
    required this.onTap,
    super.key,
  });
  final String avatar;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        width: 110,
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(
                  color: skillBuddyTheme.electric,
                  width: 3,
                )
              : null,
        ),
        child: Image.network(
          avatar,
          fit: BoxFit.fill,
          loadingBuilder: (
            BuildContext context,
            Widget child,
            ImageChunkEvent? loadingProgress,
          ) {
            if (loadingProgress == null) {
              return child;
            }
            return const AvatarShimmerPlaceholder();
          },
          errorBuilder: (
            BuildContext context,
            Object error,
            StackTrace? stackTrace,
          ) {
            return const Icon(
              Icons.error,
              color: Colors.white,
            );
          },
        ),
      ),
    );
  }
}
