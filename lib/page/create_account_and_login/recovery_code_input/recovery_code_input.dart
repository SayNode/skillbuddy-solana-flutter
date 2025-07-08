import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../util/util.dart';
import '../../../widget/code_input_field.dart';
import '../../../widget/header_subheader.dart';
import '../../../widget/skillbuddy_button.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import '../update_password/update_password.dart';
import 'controller/recovery_code_input_controller.dart';

class RecoveryCodeInputPage extends GetView<RecoveryCodeController> {
  const RecoveryCodeInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RecoveryCodeController());
    return SkillBuddyScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getRelativeHeight(8),
            horizontal: getRelativeWidth(12),
          ),
          child: Column(
            children: <Widget>[
              HeaderAndSubHeader(
                header: 'Password recovery'.tr,
                subHeader:
                    'Please enter the code you received on your registered email address to reset your password.'
                        .tr,
              ),
              Gap(getRelativeHeight(50)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Gap(getRelativeWidth(40)),
                  Expanded(
                    child: CodeInputField(
                      focusNode: controller.focusNode1,
                      nextFocusNode: controller.focusNode2,
                    ),
                  ),
                  Expanded(
                    child: CodeInputField(
                      focusNode: controller.focusNode2,
                      nextFocusNode: controller.focusNode3,
                    ),
                  ),
                  Expanded(
                    child: CodeInputField(
                      focusNode: controller.focusNode3,
                      nextFocusNode: controller.focusNode4,
                    ),
                  ),
                  Expanded(
                    child: CodeInputField(
                      focusNode: controller.focusNode4,
                      nextFocusNode: controller.focusNode4,
                    ),
                  ),
                  Gap(getRelativeWidth(40)),
                ],
              ),
              const Spacer(),
              SkillBuddyButton(
                text: 'Continue'.tr,
                // ignore: inference_failure_on_function_invocation
                onTap: () => Get.to(const UpdatePasswordPage()),
              ),
              Gap(getRelativeHeight(30)),
            ],
          ),
        ),
      ),
    );
  }
}
