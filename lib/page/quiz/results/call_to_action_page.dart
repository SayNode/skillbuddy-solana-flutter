import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/content/course.dart';
import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../widget/skillbuddy_button.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import 'controller/quiz_results_controller.dart';

class CallToActionPage extends GetView<QuizResultsController> {
  const CallToActionPage({required this.nextStep, super.key});
  final NextStep nextStep;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;

    return SkillBuddyScaffold(
      title: '',
      backButton: true,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  nextStep.message,
                  style:
                      SkillBuddyTypography.fromColor(theme.graphite).kParagraph,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 350,
              child: Transform.flip(
                flipX: true,
                child: const RiveAnimation.asset(
                  'asset/animations/first_crane.riv',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(height: 40),
            SkillBuddyButton(
              text: 'Discover More',
              onTap: () async {
                if (nextStep.link.isNotEmpty && nextStep.link != '') {
                  await launchUrl(
                    Uri.parse(nextStep.link),
                    mode: LaunchMode.externalApplication,
                  );
                }
                // ignore: inference_failure_on_function_invocation
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
