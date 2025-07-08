import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_model.dart';
import '../../service/user_state_service.dart';
import '../../widget/popups/popup_manager.dart';
import '../profile/donate_list_page.dart';

class TokenListController extends GetxController {
  User get user => Get.find<UserStateService>().user.value;
  RxDouble bitcoinPriceInDollar = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    // Fetch the Bitcoin price
    fetchBitcoinPrice();
  }

  Future<void> fetchBitcoinPrice() async {
    const String url =
        'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd';
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final int price = (data['bitcoin']
            as Map<String, dynamic>)['usd']; // Extract the USD price of Bitcoin
        final double bitcoinAmountSats = user.token / 100000000;
        bitcoinPriceInDollar.value =
            price * bitcoinAmountSats; // Update the observable

        // Save the price in shared storage
        await prefs.setDouble('bitcoinPriceInUSD', bitcoinPriceInDollar.value);
      } else {
        // Rate limit reached or other error; get price from shared storage
        final double? storedPrice = prefs.getDouble('bitcoinPriceInUSD');
        if (storedPrice != null) {
          bitcoinPriceInDollar.value = storedPrice;
        }
        if (kDebugMode) {
          print('Failed to fetch Bitcoin price: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching Bitcoin price: $e');
      }
    }
  }

  @override
  Future<void> refresh() async {
    await Get.find<UserStateService>().get();

    // Refresh the Bitcoin price as well
    await fetchBitcoinPrice();
  }

  void withdraw() {
    if (Get.find<UserStateService>().user.value.isVerified) {
      PopupManager.openPayoutPopup();
    } else {
      PopupManager.openPayoutWallet();
    }
  }

  void donatePage() {
    Get.to<void>(() => const DonateListPage());
  }
}
