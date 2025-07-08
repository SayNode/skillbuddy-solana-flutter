import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../widget/skillbuddy_scaffold.dart';
import 'controllers/loading_controller.dart';

class LoadingPage extends GetView<LoadingController> {
  const LoadingPage({
    required this.title,
    super.key,
    this.job,
    this.subtitle,
  });

  final void Function()? job;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    final Size screenSize = MediaQuery.of(context).size;
    Get.put(LoadingController(job: job));
    return SkillBuddyScaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: SpinKitCircle(
              color: theme.electric,
              size: screenSize.width * 0.6,
            ),
          ),
          SizedBox(
            width: screenSize.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenSize.height * 0.04),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.04,
                  ),
                  child: Text(
                    title,
                    style:
                        SkillBuddyTypography.fromColor(theme.graphite).kTitle,
                  ),
                ),
                if (subtitle != null)
                  SizedBox(height: screenSize.height * 0.015),
                if (subtitle != null)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.04,
                    ),
                    child: Text(
                      subtitle!,
                      style: SkillBuddyTypography.fromColor(theme.slate)
                          .kParagraph,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
