import 'package:get/get.dart';

import '../service/logger_service.dart';

class SkillBuddyConstants {
  static const String apiDomain = String.fromEnvironment('API_DOMAIN');
  static const String apiKey = String.fromEnvironment('API_KEY');

  static bool get devMode => apiDomain.contains('dev');

  static LoggerService logger = Get.find<LoggerService>();

  static const String testnetRpcUrl = 'https://api.testnet.solana.com';
  static const String testnetWsUrl = 'wss://api.testnet.solana.com';
  static const String testnetCluster = 'testnet';
  static const String mainnetRpcUrl = 'https://api.mainnet-beta.solana.com';
  static const String mainnetWsUrl = 'wss://api.mainnet-beta.solana.com';
  static const String mainnetCluster = 'mainnet-beta';
}
