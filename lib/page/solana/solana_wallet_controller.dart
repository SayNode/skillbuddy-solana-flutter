// lib/controllers/wallet_controller.dart
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:solana_mobile_client/solana_mobile_client.dart';

class WalletController extends GetxController {
  // reactive state
  final RxBool isConnected = false.obs;
  final Rx<Uint8List?> publicKey = Rx<Uint8List?>(null);
  final RxString accountLabel = ''.obs;

  late LocalAssociationScenario _session;
  late MobileWalletAdapterClient _client;
  String? _authToken;

  /// Connects to the mobile wallet, requests authorization, and stores the result.
  Future<void> connect() async {
    // 1. Create a local association scenario
    _session = await LocalAssociationScenario.create();
    await _session.startActivityForResult(null);

    // 2. Start the MWA client
    _client = await _session.start();

    // 3. Request authorization (this pops up the wallet UI)
    final result = await _client.authorize(
      identityName: 'SkillBuddy DApp',
      identityUri: Uri.parse('https://skillbuddy.io'),
      iconUri: Uri.parse(
          'https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://www.skillbuddy.io/&size=256'),
      cluster: 'testnet', // or 'mainnet-beta'
    );
    if (result != null) {
      _authToken = result.authToken;
      publicKey.value = result.publicKey;
      accountLabel.value = result.accountLabel ?? '';
      isConnected.value = true;
    }

    // (optional) close the session if you don't need further calls:
    // await _session.close();
  }

  /// Deauthorizes and cleans up state.
  Future<void> disconnect() async {
    if (_authToken != null) {
      await _client.deauthorize(authToken: _authToken!);
      await _session.close();
    }
    _authToken = null;
    publicKey.value = null;
    accountLabel.value = '';
    isConnected.value = false;
  }
}
