import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get/get.dart';

import '../model/events/skillbuddy_event.dart';

class BranchService extends GetxService {
  /// Tracks an event with Branch.
  Future<void> trackEvent(SkillBuddyEvent event) async {
    try {
      if (event.branchStandardToken != null) {
        final BranchEvent branchEvent =
            BranchEvent.standardEvent(event.branchStandardToken!);
        for (final MapEntry<String, Object> entry
            in event.getParameters().entries) {
          branchEvent.addCustomData(entry.key, entry.value);
        }
        FlutterBranchSdk.trackContent(
          buo: <BranchUniversalObject>[],
          branchEvent: branchEvent,
        );
      } else if (event.branchCustomEvent != null) {
        final BranchEvent branchEvent =
            BranchEvent.customEvent(event.branchCustomEvent!);
        for (final MapEntry<String, Object> entry
            in event.getParameters().entries) {
          branchEvent.addCustomData(entry.key, entry.value);
        }
        FlutterBranchSdk.trackContent(
          buo: <BranchUniversalObject>[],
          branchEvent: branchEvent,
        );
      }
    } catch (e) {
      Get.log('Branch SDK Event Logging Error: $e');
    }
  }
}
