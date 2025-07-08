import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/user_state_service.dart';

class EditNameController extends GetxController {
  EditNameController({required this.name});

  final String name;

  late TextEditingController nameController = TextEditingController(text: name);

  Future<void> saveName() async {
    await Get.find<UserStateService>().update(
      userName: nameController.text,
    );
    Get.back<void>();
  }
}
