import 'package:get/get.dart';

import '../model/events/skillbuddy_event.dart';
import 'analytics_service.dart';
import 'branch_service.dart';

class EventService extends GetxService {
  Future<void> trackEvent(SkillBuddyEvent event) async {
    await Get.find<AnalyticsService>().trackEvent(event);
    await Get.find<BranchService>().trackEvent(event);
  }
}
