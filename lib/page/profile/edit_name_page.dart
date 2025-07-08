import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../util/util.dart';
import '../../widget/header_subheader.dart';
import '../../widget/skillbuddy_button.dart';
import '../../widget/skillbuddy_scaffold.dart';
import '../../widget/skillbuddy_textfield.dart';
import 'controller/edit_name_controller.dart';

class EditNamePage extends GetView<EditNameController> {
  const EditNamePage({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    Get.put(EditNameController(name: name));
    return SkillBuddyScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getRelativeWidth(15),
              ),
              child: HeaderAndSubHeader(
                header: 'Edit your Name'.tr,
                subHeader: '',
              ),
            ),
            Gap(getRelativeHeight(56)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getRelativeWidth(15),
              ),
              child: SkillBuddyTextField(
                hintText: 'Write your name'.tr,
                title: 'Name'.tr,
                controller: controller.nameController,
              ),
            ),
            Gap(getRelativeHeight(24)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getRelativeWidth(15),
              ),
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
