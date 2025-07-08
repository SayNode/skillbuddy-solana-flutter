import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/user_state_service.dart';

class EditBioController extends GetxController {
  EditBioController({required this.bio});

  final String bio;

  late TextEditingController bioController = TextEditingController(text: bio);

  Future<void> saveBio() async {
    await Get.find<UserStateService>().update(
      bio: bioController.text,
    );
    Get.back<void>();
  }
}
