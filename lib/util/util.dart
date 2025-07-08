import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../service/user_state_service.dart';

bool getMaterialAppCalled = false;

double getRelativeWidth(double width) {
  final Size screenSize = MediaQuery.of(Get.context!).size;
  return screenSize.width *
      (width / 428); // TODO: check this value with your current design
}

double getRelativeHeight(double height) {
  final Size screenSize = MediaQuery.of(Get.context!).size;
  return screenSize.height *
      (height / 926); // TODO: check this value with your current design
}

Future<void> launchUrlLink(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

//   function to check if userName = '' and if it does set username to email.split('@').first
Future<void> checkUserName() async {
  if (Get.find<UserStateService>().user.value.name == '') {
    await Get.find<UserStateService>().update(
      userName: Get.find<UserStateService>().user.value.email.split('@').first,
    );
  }
}

String letterFromIndex(int i) => String.fromCharCode(65 + i);
