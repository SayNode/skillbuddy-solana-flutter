import 'package:flutter/material.dart';

import '../../../../service/theme_service.dart';

class Dot extends StatelessWidget {
  const Dot({required this.index, required this.dotSelected, super.key});

  final int index;
  final bool dotSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: dotSelected ? 10 : 8,
        height: dotSelected ? 10 : 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: dotSelected
              ? ThemeService().theme.electric
              : ThemeService().theme.seashell,
        ),
      ),
    );
  }
}
