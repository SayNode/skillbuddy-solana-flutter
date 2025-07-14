import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../util/util.dart';
import '../../../widget/skillbuddy_small_button.dart';
import '../edit_profile_page.dart';

class TopSectionOfProfile extends StatelessWidget {
  const TopSectionOfProfile({
    required this.userName,
    required this.userJoined,
    required this.userDescription,
    required this.image,
    this.buttonText = '',
    this.onTapImage,
    this.onTapName,
    this.onTapFriends,
    this.onTapFollow,
    this.onTapBio,
    this.editable = false,
    this.userFriends,
    this.showFriends = true,
    super.key,
  });
  final String userName;
  final String userJoined;
  final String userDescription;
  final String image;
  final int? userFriends;
  final bool showFriends;
  final bool editable;
  final String buttonText;
  final void Function()? onTapImage;
  final void Function()? onTapFriends;
  final void Function(String bio)? onTapBio;
  final void Function()? onTapFollow;
  final void Function(String name)? onTapName;

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    return Row(
      children: <Widget>[
        // Gap(getRelativeWidth(30)),
        SizedBox(
          width: getRelativeWidth(90),
          height: getRelativeWidth(90),
          child: Stack(
            children: <Widget>[
              CircleAvatar(
                radius: getRelativeWidth(45),
                foregroundImage: image.isEmpty
                    ? const AssetImage('asset/images/avatar_default.png')
                        as ImageProvider<Object>
                    : NetworkImage(image) as ImageProvider<Object>,
                backgroundImage:
                    const AssetImage('asset/images/avatar_default.png'),
              ),
            ],
          ),
        ),
        Gap(getRelativeWidth(30)),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Material(
                borderRadius: BorderRadius.circular(8),
                color: skillBuddyTheme.linen,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => onTapName?.call(userName),
                  child: Text(
                    userName,
                    style: SkillBuddyTypography.fromColor(
                      skillBuddyTheme.graphite,
                    ).kTitle,
                  ),
                ),
              ),
              Gap(getRelativeHeight(8)),
              Material(
                borderRadius: BorderRadius.circular(8),
                color: skillBuddyTheme.linen,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    text: TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text:
                              userDescription.isEmpty || userDescription.isEmpty
                                  ? "Hello, I'm a new user!".tr
                                  : '$userDescription ',
                          style: SkillBuddyTypography.fromColor(
                            skillBuddyTheme.graphite,
                          ).kParagraph,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(getRelativeHeight(8)),
              if (showFriends)
                GestureDetector(
                  onTap: onTapFriends,
                  child: Text(
                    '$userFriends ${userFriends == 1 ? 'friend'.tr : 'friends'.tr}',
                    style: SkillBuddyTypography.fromColor(skillBuddyTheme.slate)
                        .kParagraph,
                  ),
                )
              else
                const SizedBox(),
              if (buttonText.isEmpty)
                const SizedBox()
              else
                SkillBuddySmallButton(
                  onTap: onTapFollow ?? () {},
                  text: buttonText,
                ),
              Gap(getRelativeHeight(10)),
              if (editable)
                InkWell(
                  onTap: () => Get.to<void>(
                    () => const EditProfilePage(),
                  ),
                  child: Text(
                    'Edit profile'.tr,
                    style: SkillBuddyTypography.fromColor(
                      skillBuddyTheme.electric,
                    ).kParagraph,
                  ),
                ),
            ],
          ),
        ),
        Gap(getRelativeWidth(15)),
      ],
    );
  }
}
