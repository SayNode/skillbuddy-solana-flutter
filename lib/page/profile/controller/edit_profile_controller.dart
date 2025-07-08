import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/user_model.dart';
import '../../../service/user_state_service.dart';
import '../../avatar/avatar_page.dart';

class EditProfileController extends GetxController {
  EditProfileController();

  Rx<User> get user => Get.find<UserStateService>().user;

  RxString avatar = ''.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    avatar.value = user.value.avatar;
    nameController.text = user.value.name;
    bioController.text = user.value.bio;
  }

  void updateAvatar() {
    Get.to<String?>(() => AvatarPage(avatar.value))?.then(
      (String? value) => avatar.value = value ?? avatar.value,
    );
  }

  Future<void> saveName() async {
    await Get.find<UserStateService>().update(
      userName: nameController.text,
      bio: bioController.text,
      avatar: avatar.value,
    );
    Get.back<void>();
  }
}
