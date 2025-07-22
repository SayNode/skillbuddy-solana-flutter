import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive; // Alias Rive import

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/skillbuddy_button.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import 'controller/onboarding_controller.dart';
import 'widgets/dot.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnboardingController());
    final CustomTheme theme = Get.put(ThemeService()).theme;
    final Size screenSize = MediaQuery.of(context).size;
    return SkillBuddyScaffold(
      backgroundColor: theme.seashell,
      useSafeArea: false,
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Gap(MediaQuery.of(context).viewPadding.top),
              Gap(getRelativeHeight(40)),
              SizedBox(
                width: screenSize.width * 0.45,
                child: Image.asset(
                  'asset/images/logo_SkillBuddy.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              // Gap(getRelativeHeight(60)),
              SizedBox(
                height: screenSize.height * 0.32,
                child: Obx(
                  () => rive.RiveAnimation.asset(
                    controller.riveAnimations[controller.currentPage.value],
                  ),
                ),
              ),
              Gap(getRelativeHeight(25)),
            ],
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Gap(getRelativeHeight(40)),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getRelativeHeight(18)),
                    child: Obx(
                      () => Row(
                        children: List<Widget>.generate(
                          controller.onboardingPageTitles.length,
                          (int dotIndex) => Material(
                            color: Colors.transparent,
                            shape: const CircleBorder(),
                            child: InkWell(
                              onTap: () => controller.jumpTo(dotIndex),
                              customBorder: const CircleBorder(),
                              child: Dot(
                                index: dotIndex,
                                dotSelected:
                                    controller.currentPage.value == dotIndex,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(getRelativeHeight(15)),
                  Expanded(
                    child: PageView(
                      onPageChanged: (int index) {
                        controller.currentPage.value = index;
                      },
                      controller: controller.pageViewController,
                      children: <Widget>[
                        for (int i = 0;
                            i < controller.onboardingPageTitles.length;
                            i++)
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getRelativeHeight(18),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    AutoSizeText(
                                      '#${i + 1} ',
                                      style: SkillBuddyTypography.fromColor(
                                        theme.electric,
                                      ).kTitle,
                                      minFontSize: 10,
                                      maxLines: 1,
                                    ),
                                    Flexible(
                                      child: AutoSizeText(
                                        controller.onboardingPageTitles[i],
                                        style: SkillBuddyTypography.fromColor(
                                          theme.graphite,
                                        ).kTitle,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Gap(
                                getRelativeHeight(8),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getRelativeHeight(18),
                                ),
                                child: Text(
                                  controller.onboardingPageDescriptions[i],
                                  style: SkillBuddyTypography.fromColor(
                                    theme.slate,
                                  ).kParagraph,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getRelativeHeight(18),
                    ),
                    child: SkillBuddyButton(
                      text: 'Continue'.tr,
                      onTap: controller.proceed,
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: controller.skip,
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: Text(
                        'Skip Intro'.tr,
                        style: SkillBuddyTypography.fromColor(theme.slate)
                            .kParagraph,
                      ),
                    ),
                  ),
                  Gap(getRelativeHeight(9)),
                  Gap(MediaQuery.of(context).viewPadding.bottom),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
