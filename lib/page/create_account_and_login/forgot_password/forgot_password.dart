// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../util/util.dart';
import '../../../widget/header_subheader.dart';
import '../../../widget/skillbuddy_button.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import '../../../widget/skillbuddy_textfield.dart';
import 'controller/forgot_password_controller.dart';

class ForgotPassword extends GetView<ForgotPasswordController> {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ForgotPasswordController());

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
                header: 'Forgot Password?'.tr,
                subHeader:
                    'Don’t worry! It happens. Please enter the email associated with your account.'
                        .tr,
              ),
              const Gap(50),
              Form(
                key: controller.formKey,
                child: SkillBuddyTextField(
                  keyBoardType: TextInputType.emailAddress,
                  title: 'Email address'.tr,
                  hintText: 'name@email.com',
                  controller: controller.emailController,
                  validator: controller.validator,
                  onChanged: (String? text) =>
                      controller.formKey.currentState!.validate(),
                ),
              ),
              const Spacer(),
              Obx(
                () => SkillBuddyButton(
                  text: 'Send code'.tr,
                  onTap: () => controller.onSubmit(),
                  locked: !controller.isValid.value,
                ),
              ),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}
