import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../model/user_model.dart';
import '../../../util/util.dart';
import '../../settings/settings.dart';
import 'top_section_profile.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.user,
    super.key,
    this.onTapImage,
    this.onTapBio,
    this.onTapFriends,
    this.onTapFollow,
    this.backButtonFunction,
    this.onTapName,
    this.backButton = false,
    this.showSettings = true,
    this.editable = true,
    this.buttonText = '',
    this.showFriends = false,
    this.userFriends = -1,
  });

  final User user;
  final void Function()? onTapImage;
  final void Function(String bio)? onTapBio;
  final void Function()? onTapFriends;
  final void Function()? onTapFollow;
  final void Function()? backButtonFunction;
  final void Function(String name)? onTapName;
  final bool backButton;
  final bool showSettings;
  final bool editable;
  final String buttonText;
  final bool showFriends;
  final int userFriends;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (backButton)
              Padding(
                padding: EdgeInsets.only(
                  left: getRelativeWidth(15),
                ),
                child: IconButton(
                  onPressed: () => backButtonFunction ?? Get.back<void>(),
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                ),
              )
            else
              Container(),
            if (showSettings)
              Padding(
                padding: EdgeInsets.only(
                  right: getRelativeWidth(15),
                ),
                child: IconButton(
                  onPressed: () => Get.to<Widget>(
                    () => const SettingsPage(),
                    transition: Transition.upToDown,
                  ),
                  icon: SvgPicture.asset('asset/icons/settings_icon.svg'),
                ),
              )
            else
              Container(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getRelativeWidth(22),
            top: getRelativeHeight(48),
          ),
          child: TopSectionOfProfile(
            userName: user.name,
            userJoined: user.dateJoined,
            userDescription: user.bio,
            userFriends: userFriends,
            editable: editable,
            image: user.avatar,
            onTapImage: onTapImage,
            onTapBio: onTapBio,
            onTapFriends: onTapFriends,
            showFriends: showFriends,
            buttonText: buttonText,
            onTapFollow: onTapFollow,
          ),
        ),
      ],
    );
  }
}
