import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../util/util.dart';
import '../controller/leaderboard_controller.dart';
import 'days_weeks_month_button.dart';

class DaysWeeksMonthsRow extends StatelessWidget {
  const DaysWeeksMonthsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CustomTheme skillBuddyTheme = ThemeService().theme;
    final LeaderboardController controller = Get.put(LeaderboardController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Obx(
            () => DaysWeeksMonthsButton(
              text: 'Day',
              onTap: () => controller.changeDuration(DurationType.day),
              textColor: controller.selectedDuration.value == DurationType.day
                  ? skillBuddyTheme.electric
                  : skillBuddyTheme.graphite,
              color: controller.selectedDuration.value == DurationType.day
                  ? skillBuddyTheme.seashell
                  : skillBuddyTheme.linen,
            ),
          ),
        ),
        Gap(getRelativeWidth(2)),
        Expanded(
          child: Obx(
            () => DaysWeeksMonthsButton(
              text: 'Week',
              onTap: () => controller.changeDuration(DurationType.week),
              textColor: controller.selectedDuration.value == DurationType.week
                  ? skillBuddyTheme.electric
                  : skillBuddyTheme.graphite,
              color: controller.selectedDuration.value == DurationType.week
                  ? skillBuddyTheme.seashell
                  : skillBuddyTheme.linen,
            ),
          ),
        ),
        Gap(getRelativeWidth(2)),
        Expanded(
          child: Obx(
            () => DaysWeeksMonthsButton(
              text: 'Month',
              onTap: () => controller.changeDuration(DurationType.month),
              textColor: controller.selectedDuration.value == DurationType.month
                  ? skillBuddyTheme.electric
                  : skillBuddyTheme.graphite,
              color: controller.selectedDuration.value == DurationType.month
                  ? skillBuddyTheme.seashell
                  : skillBuddyTheme.linen,
            ),
          ),
        ),
      ],
    );
  }
}
