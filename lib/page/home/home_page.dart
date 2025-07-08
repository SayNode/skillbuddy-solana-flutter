import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/controller/skillbody_navigation_bar_controller.dart';
import '../../widget/skillbuddy_scaffold.dart';

class HomePage extends GetView<SkillBuddyNavigationBarController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final SkillBuddyNavigationBarController controller =
        Get.put(SkillBuddyNavigationBarController());
    return SkillBuddyScaffold(
      body: Obx(() => controller.getPageFor(controller.selectedPage)),
      useNavigationBar: true,
    );
  }
}
