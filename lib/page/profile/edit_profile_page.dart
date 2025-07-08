import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../service/theme_service.dart';
import '../../theme/theme.dart';
import '../../util/util.dart';
import '../../widget/skillbuddy_button.dart';
import '../../widget/skillbuddy_scaffold.dart';
import '../../widget/skillbuddy_textfield.dart';
import 'controller/edit_profile_controller.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get.put(EditProfileController(name: name));
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    Get.put(EditProfileController());
    return SkillBuddyScaffold(
      resizeToAvoidBottomInset: true,
      backButton: true,
      title: 'Edit your profile'.tr,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: getRelativeWidth(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: InkWell(
                onTap: controller.updateAvatar,
                child: Obx(
                  () => Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: getRelativeWidth(60),
                        foregroundImage: controller.avatar.value.isEmpty
                            ? const AssetImage(
                                'asset/images/avatar_default.png',
                              ) as ImageProvider<Object>
                            : NetworkImage(controller.avatar.value)
                                as ImageProvider<Object>,
                        backgroundImage:
                            const AssetImage('asset/images/avatar_default.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: skillBuddyTheme.linen,
                            ),
                            color: skillBuddyTheme.electric,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Icon(
                              Icons.edit,
                              color: skillBuddyTheme.linen,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Gap(getRelativeHeight(56)),
            SkillBuddyTextField(
              hintText: 'Write your name'.tr,
              title: 'Name'.tr,
              controller: controller.nameController,
              maxLength: 20,
            ),
            Gap(getRelativeHeight(24)),
            SkillBuddyTextField(
              hintText: 'Write your bio'.tr,
              title: 'Bio'.tr,
              controller: controller.bioController,
              maxLines: 6,
            ),
            Gap(getRelativeHeight(24)),
            Align(
              alignment: Alignment.bottomCenter,
              child: SkillBuddyButton(
                text: 'Save',
                onTap: controller.saveName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
