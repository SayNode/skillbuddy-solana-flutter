import 'package:get/get.dart';

import 'solana_service.dart';

class SolanaWalletController extends GetxController {
  final SolanaService solanaService = Get.find<SolanaService>();

  void toggleNetwork() {
    solanaService.network.value =
        solanaService.network.value == SolanaNetwork.testnet
            ? SolanaNetwork.mainnet
            : SolanaNetwork.testnet;
  }

  Future<void> authorizeWallet() async {
    await solanaService.authorizeWallet();
  }

  Future<void> deauthorizeWallet() async {
    await solanaService.deauthorizeWallet();
  }
}
