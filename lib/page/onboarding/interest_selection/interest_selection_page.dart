// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/interest_service.dart';
import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/skillbuddy_button.dart';
import '../../../widget/skillbuddy_chip.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import '../../error/error_page.dart';
import '../../loading/loading_page.dart';

class InterestSelectionPage extends StatelessWidget {
  const InterestSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;
    final InterestService interestService = Get.find<InterestService>();

    return FutureBuilder<void>(
      future: interestService.waitUntilReady(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage(title: 'Loading areas of interest'.tr);
        } else if (snapshot.hasError) {
          return ErrorPage(error: "Couldn't load areas of interest".tr);
        } else {
          return SkillBuddyScaffold(
            backgroundColor: theme.linen,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Gap(getRelativeHeight(36)),
                  Text(
                    "Choose areas you'd like to elevate".tr,
                    style:
                        SkillBuddyTypography.fromColor(theme.graphite).kTitle,
                  ),
                  Gap(getRelativeHeight(18)),
                  Text(
                    'Personalize your learning journey. Select the topics that fuel your curiosity and watch your skills soar.'
                        .tr,
                    style:
                        SkillBuddyTypography.fromColor(theme.slate).kParagraph,
                  ),
                  const Spacer(),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: <Widget>[
                      for (int i = 0;
                          i <
                              interestService
                                  .interestSelection.value.areas.length;
                          i++)
                        Obx(
                          () {
                            final AreaOfInterest areaOfInterest =
                                interestService
                                    .interestSelection.value.areas[i];
                            return SkillBuddyChip(
                              onTap: () {
                                interestService
                                        .isSelected(areaOfInterest)
                                        .value =
                                    !interestService
                                        .isSelected(areaOfInterest)
                                        .value;
                                interestService.setInterestSelectionIndex(i);
                              },
                              selected: interestService
                                  .isSelected(areaOfInterest)
                                  .value,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  interestService
                                      .interestSelection.value.areas[i].title,
                                  style: SkillBuddyTypography.fromColor(
                                    theme.graphite,
                                  ).kParagraph,
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                  const Spacer(flex: 4),
                  Obx(
                    () {
                      return SkillBuddyButton(
                        text: 'Next'.tr,
                        onTap: interestService.next,
                        locked: !interestService.validInterestSelection.value,
                      );
                    },
                  ),
                  Center(
                    child: TextButton(
                      onPressed: interestService.skip,
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: Text(
                        'Skip for now'.tr,
                        style: SkillBuddyTypography.fromColor(theme.slate)
                            .kParagraph,
                      ),
                    ),
                  ),
                  Gap(getRelativeHeight(9)),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
