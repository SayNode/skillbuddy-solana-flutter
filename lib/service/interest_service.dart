import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';

import '../page/home/home_page.dart';
import '../page/onboarding/time_selection/time_selection.dart';
import 'api_service.dart';
import 'user_state_service.dart';

class AreaOfInterest {
  AreaOfInterest({
    required this.title,
  });
  factory AreaOfInterest.fromJson(Map<String, dynamic> json) {
    final String key = json.keys.first;
    return AreaOfInterest(
      title: json[key],
    );
  }

  final String title;
}

class AreasOfInterest {
  AreasOfInterest({
    required this.areas,
  });

  factory AreasOfInterest.fromJson(List<dynamic> jsonList) {
    final List<AreaOfInterest> areas = jsonList
        .map(
          (dynamic json) =>
              AreaOfInterest.fromJson(json as Map<String, dynamic>),
        )
        .toList();
    return AreasOfInterest(areas: areas);
  }
  final List<AreaOfInterest> areas;
}

class InterestService extends GetxService {
  Rx<AreasOfInterest> interestSelection =
      AreasOfInterest(areas: <AreaOfInterest>[]).obs;
  Rx<AreasOfInterest> selectedInterests =
      AreasOfInterest(areas: <AreaOfInterest>[]).obs;
  RxBool validInterestSelection = false.obs;
  final Completer<void> _interestsFetchCompleter = Completer<void>();

  @override
  Future<void> onInit() async {
    super.onInit();
    interestSelection.value = await getAreasOfInterest();
    _interestsFetchCompleter.complete();
  }

  Future<void> waitUntilReady() => _interestsFetchCompleter.future;

  void setInterestSelectionIndex(int index) {
    if (selectedInterests.value.areas
        .contains(interestSelection.value.areas[index])) {
      selectedInterests.value.areas
          .remove(interestSelection.value.areas[index]);
    } else {
      selectedInterests.value.areas.add(interestSelection.value.areas[index]);
    }
    validInterestSelection.value = selectedInterests.value.areas.isNotEmpty;
  }

  final Map<AreaOfInterest, RxBool> selectedStates = <AreaOfInterest, RxBool>{};
  RxBool isSelected(AreaOfInterest item) {
    selectedStates.putIfAbsent(item, () => RxBool(false));
    return selectedStates[item]!;
  }

  void next() {
    if (validInterestSelection.value) {
      Get.find<UserStateService>().update(
        areasOfInterest: selectedInterests.value.areas
            .map(
              (AreaOfInterest e) => e.title,
            )
            .toList(),
      );

      Get.off<void>(
        () => const TimeSelectionPage(),
      );
    }
  }

  void skip() {
    Get.off<void>(
      () => const HomePage(),
    );
  }

  Future<AreasOfInterest> getAreasOfInterest() async {
    final ApiResponse response =
        await Get.find<APIService>().get('/areas-of-interest/');

    if (response.success && response.message != null) {
      final dynamic areasOfInterest = json.decode(response.message!);

      return AreasOfInterest(
        areas: <AreaOfInterest>[
          for (final dynamic item in areasOfInterest)
            // Todo remove id since it's not used anymore
            AreaOfInterest(title: item),
        ],
      );
    } else {
      throw Exception(
        'Failed to retrieve areas of interest: (status code ${response.statusCode}) ${response.message}',
      );
    }
  }
}
