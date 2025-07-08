import 'package:get/get.dart';

import '../service/logger_service.dart';

class SkillBuddyConstants {
  static const String apiDomain = String.fromEnvironment('API_DOMAIN');
  static const String apiKey = String.fromEnvironment('API_KEY');

  static bool get devMode => apiDomain.contains('dev');

  static LoggerService logger = Get.find<LoggerService>();
}
