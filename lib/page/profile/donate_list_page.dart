import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../model/charity_model.dart';
import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../theme/typography.dart';
import '../../util/util.dart';
import '../../widget/popups/popup_manager.dart';
import '../../widget/skillbuddy_scaffold.dart';
import 'controller/donate_list_controller.dart';

class DonateListPage extends GetView<DonateListController> {
  const DonateListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SkillBuddyScaffold(
      title: 'Donate'.tr,
      backButton: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(16)),
        child: GetBuilder<DonateListController>(
          builder: (DonateListController controller) {
            final List<Charity> charities = controller.charities;

            return ListView.separated(
              padding: EdgeInsets.only(top: getRelativeHeight(34)),
              itemCount: charities.length,
              itemBuilder: (BuildContext context, int index) {
                final Charity charity = charities[index];
                return CharityTile(
                  image: charity.image,
                  title: charity.title,
                  charityAddress: charity.charityAddress,
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  Gap(getRelativeHeight(12)),
            );
          },
        ),
      ),
    );
  }
}

class CharityTile extends StatelessWidget {
  const CharityTile({
    required this.image,
    required this.title,
    required this.charityAddress,
    super.key,
  });

  final String image;
  final String title;
  final String charityAddress;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;

    return InkWell(
      onTap: () {
        PopupManager.donatePayoutPopup(
          charityAddress: charityAddress,
        );
      },
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            image,
          ),
          Gap(getRelativeWidth(12)),
          Text(
            title,
            style: SkillBuddyTypography.fromColor(
              skillBuddyTheme.graphite,
            ).kInterSmall,
          ),
        ],
      ),
    );
  }
}
