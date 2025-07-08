import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../widget/header_subheader.dart';
import '../../widget/skillbuddy_button.dart';
import '../../widget/skillbuddy_scaffold.dart';
import '../../widget/skillbuddy_textfield.dart';
import '../../../util/util.dart';

import 'controller/edit_bio_controller.dart';

class EditBioPage extends GetView<EditBioController> {
  const EditBioPage({required this.bio, super.key});

  final String bio;

  @override
  Widget build(BuildContext context) {
    Get.put(EditBioController(bio: bio));
    return SkillBuddyScaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getRelativeWidth(15),
              ),
              child: HeaderAndSubHeader(
                header: 'Edit your Bio'.tr,
                subHeader: 'Tell the world a little bit about yourself'.tr,
              ),
            ),
            Gap(getRelativeHeight(56)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getRelativeWidth(15),
              ),
              child: SkillBuddyTextField(
                hintText: 'Write your bio'.tr,
                title: 'Bio'.tr,
                controller: controller.bioController,
                maxLines: 6,
              ),
            ),
            Gap(getRelativeHeight(24)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getRelativeWidth(15),
              ),
              child: SkillBuddyButton(
                text: 'Save',
                onTap: controller.saveBio,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
