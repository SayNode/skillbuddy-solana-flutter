import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import 'controller/referral_controller.dart';
import 'widgets/referral_card.dart';
import 'widgets/referral_history_section.dart';
import 'widgets/referral_people.dart';

class ReferralCodePage extends GetView<ReferralPageController> {
  const ReferralCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ReferralPageController controller = Get.put(ReferralPageController());
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    return SkillBuddyScaffold(
      title: 'Referral code'.tr,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            const Gap(15),
            Text(
              'You and your referred friend will get'.tr,
              style: SkillBuddyTypography.fromColor(
                skillBuddyTheme.graphite,
              ).kParagraph,
            ),
            const Gap(5),
            Text(
              '1 Referral  = 50 XP'.tr,
              style: SkillBuddyTypography.fromColor(
                skillBuddyTheme.graphite,
              ).kParagraphSemiBold,
            ),
            const Gap(30),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(5),
              color: skillBuddyTheme.grey,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: SizedBox(
                  height: getRelativeHeight(50),
                  width: getRelativeWidth(385),
                  child: Center(
                    child: Text(
                      ///Todo: Replace with real referral code
                      '6hgTF5Fake',
                      style: SkillBuddyTypography.fromColor(
                        skillBuddyTheme.graphite,
                      ).kTitle,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ReferralCard(
                  title: 'Copy code'.tr,
                  icon: 'asset/icons/copy_icon1.svg',
                  onTap: controller.copyToClipboard,
                ),
                ReferralCard(
                  title: 'Share code'.tr,
                  icon: 'asset/icons/share_icon2.svg',

                  ///TODO replace with real link
                  onTap: () => controller.shareReferralCode(
                    'https://play.google.com/store/apps/details?id=io.wizzer.academy',
                  ),
                ),
              ],
            ),
            const Gap(30),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: getRelativeWidth(20)),
                    child: Text(
                      'Referral history'.tr,
                      style: SkillBuddyTypography.fromColor(
                        skillBuddyTheme.graphite,
                      ).kParagraphSemiBold,
                    ),
                  ),
                  const Gap(20),

                  ///TODO replace with real data from backend
                  ReferralHistorySection(
                    image: '',
                    title: '250 XP',
                    subtitle: 'You have earned so far'.tr,
                    arrowPress: () {},
                  ),
                  Obx(
                    () => ReferralHistorySection(
                      image: '',
                      title: '3 friends',
                      subtitle: 'Referral code sent'.tr,
                      showArrow: true,
                      arrowUp: controller.showReferralsSent.value,
                      arrowPress: () => controller.showReferralsSent.value =
                          !controller.showReferralsSent.value,
                    ),
                  ),

                  const Gap(20),

                  ///TODO replace with real data from backend
                  Padding(
                    padding: EdgeInsets.only(left: getRelativeWidth(20)),
                    child: Obx(
                      () => controller.showReferralsSent.value
                          ? SizedBox(
                              height: getRelativeHeight(230),
                              child: ListView(
                                children: const <Widget>[
                                  ReferralPeople(
                                    imageUrl: '',
                                    name: 'Donatelo O',
                                    subtitle: 'Level 1 passed',
                                    status: ReferralStatus.accepted,
                                  ),
                                  ReferralPeople(
                                    imageUrl: '',
                                    name: 'Donatelo O',
                                    subtitle: '10 days streak',
                                    status: ReferralStatus.rejected,
                                  ),
                                  ReferralPeople(
                                    imageUrl: '',
                                    name: 'Donatelo O',
                                    subtitle: '10 days streak',
                                    status: ReferralStatus.accountCreated,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
