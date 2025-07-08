import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/theme_service.dart';
import '../service/user_state_service.dart';
import '../theme/theme.dart';
import '../theme/typography.dart';
import 'controller/skillbudy_list_tile_controller.dart';
import 'popups/popup_manager.dart';

class SkillbuddyListTile extends StatelessWidget {
  const SkillbuddyListTile({
    required this.image,
    required this.title,
    required this.trailing,
    super.key,
    this.onTap,
  });
  final String image;
  final String title;
  final String trailing;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;

    final ListTileController controller = Get.put(ListTileController());
    return Obx(
      () => Material(
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          tileColor: controller.isSelected.value ? theme.seashell : null,
          onTap: () async {
            controller.isSelected.toggle();
// ! this should make sense when we have more than one crypto
            if (title == 'Lightning Satoshis (LSAT)') {
              if (Get.find<UserStateService>().user.value.isVerified) {
                PopupManager.openPayoutPopup();
              } else {
                PopupManager.openPayoutWallet();
              }
            } else {
              PopupManager.openPayoutWallet();
            }
          },
          dense: true,
          leading: Image.asset(
            image,
            width: 20,
          ),
          title: Text(
            title,
            style: SkillBuddyTypography.fromColor(theme.graphite).kParagraph,
          ),
          trailing: Text(
            trailing,
            style: SkillBuddyTypography.fromColor(theme.graphite).kParagraph,
          ),
        ),
      ),
    );
  }
}
