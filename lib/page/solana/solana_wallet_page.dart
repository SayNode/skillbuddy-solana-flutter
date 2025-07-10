import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solana/base58.dart';

import 'solana_wallet_controller.dart';

class SolanaWalletPage extends GetView<WalletController> {
  const SolanaWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WalletController());

    return Scaffold(
      appBar: AppBar(title: const Text('Solana Wallet Test')),
      body: Center(
        child: Obx(() {
          if (controller.isConnected.value) {
            final pkBase58 = base58encode(controller.publicKey.value!);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Connected as:'),
                Text(
                  controller.accountLabel.value.isNotEmpty
                      ? controller.accountLabel.value
                      : pkBase58,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.disconnect,
                  child: const Text('Disconnect'),
                ),
              ],
            );
          } else {
            return ElevatedButton(
              onPressed: controller.connect,
              child: const Text('Connect Wallet'),
            );
          }
        }),
      ),
    );
  }
}
