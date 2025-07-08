import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/time_selection.dart';
import '../../../../service/user_state_service.dart';
import '../../../home/home_page.dart';
import '../../../loading/loading_page.dart';

class TimeSelectionController extends GetxController {
  Rx<int> timeSelectionIndex = (-1).obs;

  List<TimeSelection> timeSelections = <TimeSelection>[
    TimeSelection(
      5,
      10,
    ),
    TimeSelection(
      10,
      20,
    ),
    TimeSelection(
      15,
      30,
    ),
    TimeSelection(
      20,
      40,
    ),
  ];

  bool get validTimeSelection => timeSelectionIndex.value >= 0;

  // ignore: use_setters_to_change_properties
  void setTimeSelectionIndex(int index) {
    timeSelectionIndex.value = index;
  }

  void next() {
    if (validTimeSelection) {
      debugPrint('${timeSelectionIndex.value}');
      Get.off<void>(
        () => LoadingPage(
          title: 'We are crafting your learning experience'.tr,
          subtitle: 'Wait a minute we are picking content for you'.tr,
          job: () {
            Future.wait(
              <Future<void>>[
                Future<void>.delayed(2.seconds),
                (() async {
                  return Get.find<UserStateService>().update(
                    timeGrowingDaily:
                        timeSelections[timeSelectionIndex.value].minutes,
                  );
                })(),
              ],
            ).then((_) {
              Get.off<void>(() => const HomePage());
            });
          },
        ),
      );
    }
  }

  void skip() {
    Get.off<void>(
      () => const HomePage(),
    );
  }
}
