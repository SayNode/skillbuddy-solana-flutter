import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/help_center_info.dart';
import '../../../../service/auth_service.dart';
import '../../../../service/storage/storage_service.dart';
import '../../../create_account_and_login/login_page.dart';
import '../deleted_account.dart';

class DeleteAccountController extends GetxController {
  final StorageService storageService = Get.find<StorageService>();

  RxBool deleting = false.obs;
  RxInt timer = 3.obs;

  Timer? _kTimer;

  List<TextInfo> deleteInfo = <TextInfo>[
    TextInfo(
      'Data Deletion',
      'Deleting your account will permanently erase all associated data. This action is irreversible.',
    ),
    TextInfo(
      'Access Termination',
      'You will lose access to the app and its features immediately upon account deletion.',
    ),
    TextInfo(
      'Recovery Impossible',
      'Once your account is deleted, recovery is not possible. Ensure you have backed up any important information.',
    ),
  ];

  final AuthService authService = Get.put(AuthService());

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  @override
  void onClose() {
    _kTimer?.cancel();
    super.onClose();
  }

  void startTimer() {
    bool firstIteration = true;
    _kTimer = Timer.periodic(
      const Duration(milliseconds: 1100),
      (Timer timer) {
        if (this.timer.value == 0) {
          timer.cancel();
        } else {
          if (firstIteration) {
            firstIteration = false;
          } else {
            this.timer.value--;
          }
        }
      },
    );
  }

  Future<void> deleteAccount() async {
    deleting.value = true;
    await storageService.secure.deleteAll();
    await storageService.shared.deleteAll();
    await authService.deleteUser();
    await Get.off<Widget>(const DeletedAccountPage());
    deleting.value = false;
  }

  void back() {
    Get.back<Widget>();
  }

  void goToLogin() {
    Get.offAll<void>(LoginPage.new);
  }
}
