import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

import '../model/events/skillbuddy_event.dart';

class AnalyticsService extends GetxService {
  late final FirebaseAnalytics analytics;

  @override
  void onInit() {
    analytics = FirebaseAnalytics.instance;
    FirebaseAnalyticsObserver(analytics: analytics);
    super.onInit();
  }

  Future<void> trackEvent(SkillBuddyEvent event) async {
    if (event.googleToken != null) {
      await analytics.logEvent(
        name: event.googleToken!,
        parameters: event.getParameters(),
      );
    }
  }
}
