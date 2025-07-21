import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../model/content/chapter.dart';
import '../../model/content/course.dart';
import '../../model/content/lesson.dart';
import '../../model/content/module.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widget/skillbuddy_button.dart';
import '../../widget/skillbuddy_scaffold.dart';
import 'controller/lesson_controller.dart';

class LessonPage extends GetView<LessonController> {
  const LessonPage({
    required this.course,
    required this.module,
    required this.lesson,
    required this.chapter,
    required this.enrolled,
    super.key,
  });

  final Course course;
  final Module module;
  final Lesson lesson;
  final Chapter chapter;
  final bool enrolled;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    Get.put(
      LessonController(
        course: course,
        module: module,
        lesson: lesson,
        chapter: chapter,
        enrolled: enrolled,
      ),
    );
    return SkillBuddyScaffold(
      backButton: true,
      title: '${'Lesson'.tr} ${lesson.sequence}',
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  lesson.name,
                  style: SkillBuddyTypography.fromColor(
                    skillBuddyTheme.graphite,
                  ).kTitle,
                ),
                const Gap(10),
                Row(
                  children: <Widget>[
                    LessonButton(
                      text: 'Share'.tr,
                      icon: Icons.share_outlined,
                      action: () => Share.share(
                        "Hey! I'm learning with SkillBuddy and my current lesson is ${lesson.name}. Discover the exciting world of blockchain, web3, and technology while earning rewards! SkillBuddy's bite-sized courses make learning easy and enjoyable. Don't just learn, get rewarded for it — all for free.\n\nFor ios click here: https://apps.apple.com/ch/app/skillbuddy-io/id6473525692?l=en-GB \n\nFor android click here: https://play.google.com/store/apps/details?id=io.skillbuddy.academy",
                      ),
                    ),
                    Gap(getRelativeWidth(10)),
                    LessonButton(
                      text: 'Ask question'.tr,
                      icon: Icons.question_mark,
                      link: 'https://discord.com/invite/v7Su8qYSuF',
                    ),
                  ],
                ),
                Gap(getRelativeHeight(24)),
                if (lesson.content.isEmpty && lesson.image.isNotEmpty)
                  ExtendedImage.network(
                    lesson.image,
                    fit: BoxFit.cover,
                  )
                else
                  Column(
                    children: <Widget>[
                      Html(
                        data: lesson.content,
                        style: <String, Style>{
                          'body': Style(
                            color: skillBuddyTheme.graphite,
                          ),
                        },
                      ),
                    ],
                  ),
                Gap(getRelativeHeight(37)),
                SkillBuddyButton(
                  text: 'Start Quiz',
                  onTap: controller.startQuiz,
                ),
                Gap(getRelativeHeight(17)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LessonButton extends StatelessWidget {
  const LessonButton({
    required this.text,
    required this.icon,
    this.link = '',
    this.action,
    super.key,
  });
  final String text;
  final IconData icon;
  final String link;
  final Function? action;
  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;

    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        surfaceTintColor: WidgetStateProperty.all<Color>(skillBuddyTheme.linen),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        ),
      ),
      onPressed: () {
        if (link.isNotEmpty) {
          launchUrlLink(Uri.parse(link));
        }
        if (action != null) {
          // ignore: prefer_null_aware_method_calls, avoid_dynamic_calls
          action!();
        }
      },
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 20,
            color: skillBuddyTheme.slate,
          ),
          const Gap(8),
          Text(
            text,
            style: SkillBuddyTypography.fromColor(
              skillBuddyTheme.slate,
            ).kTextAdditional,
          ),
        ],
      ),
    );
  }
}
