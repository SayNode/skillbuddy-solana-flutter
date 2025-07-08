import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../service/theme_service.dart';
import '../service/user_state_service.dart';
import '../theme/theme.dart';
import '../util/util.dart';
import 'controller/skillbody_navigation_bar_controller.dart';

class SkillBuddyNavigationBar
    extends GetView<SkillBuddyNavigationBarController> {
  const SkillBuddyNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SkillBuddyNavigationBarController());
    final CustomTheme theme = ThemeService().theme;
    return SizedBox(
      height: getRelativeHeight(64),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Material(
              child: InkWell(
                child: Center(
                  child: Obx(
                    () => SvgPicture.asset(
                      'asset/icons/home_icon.svg',
                      colorFilter: ColorFilter.mode(
                        controller.selectedPage.index ==
                                NavigationBarPage.home.index
                            ? theme.electric
                            : Colors.black,
                        BlendMode.srcIn,
                      ),
                      semanticsLabel: 'Home',
                    ),
                  ),
                ),
                onTap: () => controller.changeIndex(NavigationBarPage.home),
              ),
            ),
          ),
          Expanded(
            child: Material(
              child: InkWell(
                child: Center(
                  child: Obx(
                    () => SvgPicture.asset(
                      'asset/icons/book_icon.svg',
                      colorFilter: ColorFilter.mode(
                        controller.selectedPage.index ==
                                NavigationBarPage.book.index
                            ? theme.electric
                            : Colors.black,
                        BlendMode.srcIn,
                      ),
                      semanticsLabel: 'Home',
                    ),
                  ),
                ),
                onTap: () => controller.changeIndex(NavigationBarPage.book),
              ),
            ),
          ),
          Expanded(
            child: Material(
              child: InkWell(
                child: Center(
                  child: Obx(
                    () => SvgPicture.asset(
                      'asset/icons/crown_icon.svg',
                      colorFilter: ColorFilter.mode(
                        controller.selectedPage.index ==
                                NavigationBarPage.crown.index
                            ? theme.electric
                            : Colors.black,
                        BlendMode.srcIn,
                      ),
                      semanticsLabel: 'Home',
                    ),
                  ),
                ),
                onTap: () => controller.changeIndex(NavigationBarPage.crown),
              ),
            ),
          ),
          Expanded(
            child: Material(
              child: InkWell(
                child: Center(
                  child: Obx(
                    // ignore: use_decorated_box
                    () => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: controller.selectedPage.index ==
                                  NavigationBarPage.profile.index
                              ? theme.electric
                              : Colors.transparent,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundImage: (Get.find<UserStateService>()
                                .user
                                .value
                                .avatar
                                .isEmpty
                            ? const AssetImage(
                                'asset/images/avatar_default.png',
                              )
                            : NetworkImage(
                                Get.find<UserStateService>().user.value.avatar,
                              )) as ImageProvider<Object>,
                      ),
                    ),
                  ),
                ),
                onTap: () => controller.changeIndex(NavigationBarPage.profile),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
