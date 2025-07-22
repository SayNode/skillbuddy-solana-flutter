import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../service/logger_service.dart';
import '../service/theme_service.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';
import '../util/constants.dart';
import 'skillbuddy_navigation_bar.dart';

class SkillBuddyScaffold extends StatelessWidget {
  const SkillBuddyScaffold({
    super.key,
    this.body,
    this.title,
    this.useSafeArea = true,
    this.useNavigationBar = false,
    this.backgroundColor,
    this.backButton = false,
    this.resizeToAvoidBottomInset = false,
  });
  final Widget? body;
  final String? title;
  final bool useSafeArea;
  final bool useNavigationBar;
  final Color? backgroundColor;
  final bool backButton;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    Scaffold scaffold() => Scaffold(
          backgroundColor: backgroundColor ?? theme.seashell,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          appBar: title == null
              ? null
              : AppBar(
                  forceMaterialTransparency: true,
                  centerTitle: true,
                  // Disable the automatic back button.
                  automaticallyImplyLeading: false,
                  // Provide your own custom leading widget.
                  leading: backButton
                      ? IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            size: 24,
                            color: Get.find<ThemeService>().theme.graphite,
                          ),
                          onPressed: () => Get.back<void>(),
                        )
                      : null,
                  backgroundColor: backgroundColor ?? theme.linen,
                  title: Text(
                    title!,
                    style: SkillBuddyTypography.fromColor(theme.graphite)
                        .kParagraphSemiBold,
                  ),
                ),
          body: Column(
            children: <Widget>[
              Expanded(child: body ?? const SizedBox.shrink()),
              if (useNavigationBar) const SkillBuddyNavigationBar(),
            ],
          ),
          floatingActionButton: (SkillBuddyConstants.devMode)
              ? FloatingActionButton(
                  onPressed: () {
                    Get.find<LoggerService>().show();
                  },
                  backgroundColor: Colors.blueGrey,
                  child: const Icon(Icons.logo_dev_rounded),
                )
              : null,
        );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: ColoredBox(
        color: backgroundColor ?? theme.linen,
        child: useSafeArea ? SafeArea(child: scaffold()) : scaffold(),
      ),
    );
  }
}
