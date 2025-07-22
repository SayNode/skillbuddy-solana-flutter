import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/theme_service.dart';
import '../theme/theme.dart';

Future<T?> openSkillBuddyPopup<T>(
  Widget body, {
  bool closeButton = true,
  bool dismissible = true,
  double? topPaddingCompensation,
  Color? backgroundColor,
}) async {
  final CustomTheme theme = Get.put(ThemeService()).theme;
  final Color backgroundColor0 = backgroundColor ?? theme.seashell;
  return Get.dialog<T?>(
    Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          children: <Widget>[
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: backgroundColor0,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: SingleChildScrollView(
                      child: Stack(
                        children: <Widget>[
                          body,
                          if (closeButton)
                            Row(
                              children: <Widget>[
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: GestureDetector(
                                    onTap: () => Get.back<void>(),
                                    child: Icon(
                                      Icons.close,
                                      color: theme.graphite,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else
                            Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
