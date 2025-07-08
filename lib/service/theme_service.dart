import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/storage_exception.dart';
import '../theme/theme.dart';
import 'storage/storage_service.dart';

class ThemeService extends GetxService {
  final StorageService _storage = Get.find<StorageService>();
  ThemeData get themeData => _getThemeData();

  CustomTheme get theme => Get.theme.extension<CustomTheme>()!;

  ThemeData _generateThemeData(CustomTheme kTheme) => ThemeData(
        extensions: <ThemeExtension<CustomTheme>>[
          kTheme,
        ],
        primaryColor: kTheme.electric,
        colorScheme:
            const ColorScheme.light().copyWith(primary: kTheme.electric),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: kTheme.electric,
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kTheme.electric,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: kTheme.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

  ThemeData _getThemeData() {
    final String kTheme = _getSavedTheme();

    switch (kTheme) {
      //List of themes
      case 'dark':
        return _generateThemeData(CustomTheme.dark);

      case 'light':
        return _generateThemeData(CustomTheme.light);

      default:
        return _generateThemeData(CustomTheme.light);
    }
  }

  String _getSavedTheme() {
    String value;
    try {
      value = _storage.shared.readString('themeMode') ?? '';
    } on StorageException catch (_) {
      setTheme('light');
      value = 'light';
    }

    return value;
  }

  Future<void> setTheme(String theme) async {
    await _storage.shared.writeString('themeMode', theme);
    Get.changeTheme(_getThemeData());
  }
}
