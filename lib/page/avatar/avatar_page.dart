import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/skillbuddy_scaffold.dart';
import 'controllers/avatar_page_controller.dart';
import 'widgets/avatar_shimmer_placeholder.dart';
import 'widgets/avatar_widget.dart';

class AvatarPage extends GetView<AvatarPageController> {
  const AvatarPage(this.avatar, {super.key});

  final String avatar;

  @override
  Widget build(BuildContext context) {
    return SkillBuddyScaffold(
      resizeToAvoidBottomInset: true,
      backButton: true,
      title: 'Choose profile picture'.tr,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Obx(
          () {
            if (controller.isLoaded.value) {
              return GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: controller.avatarList.length,
                itemBuilder: (BuildContext context, int index) {
                  return AvatarWidget(
                    onTap: () => controller.selectAvatar(index),
                    avatar: controller.avatarList[index],
                    isSelected: avatar == controller.avatarList[index],
                  );
                },
              );
            }
            return GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                return const AvatarShimmerPlaceholder();
              },
            );
          },
        ),
      ),
    );
  }
}
