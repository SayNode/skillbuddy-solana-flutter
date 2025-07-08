import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../util/util.dart';
import '../../../widget/skillbuddy_scaffold.dart';
import 'widget/partner_widget.dart';

class OurPartnersScreen extends StatelessWidget {
  const OurPartnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SkillBuddyScaffold(
      title: 'Our partners'.tr,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getRelativeWidth(20),
          vertical: getRelativeHeight(20),
        ),
        child: const Column(
          children: <Widget>[
            PartnerWidget(imagePath: 'asset/images/yzer.png'),
            Gap(
              15,
            ),
            PartnerWidget(imagePath: 'asset/images/yzer.png'),
          ],
        ),
      ),
    );
  }
}
