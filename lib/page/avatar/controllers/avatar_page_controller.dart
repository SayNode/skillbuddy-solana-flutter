import 'package:get/get.dart';

import '../../../service/user_state_service.dart';

class AvatarPageController extends GetxController {
  final RxBool isLoaded = false.obs;
  late List<String> avatarList;

  @override
  void onInit() {
    loadAvatarList();
    super.onInit();
  }

  Future<void> loadAvatarList() async {
    avatarList = await Get.find<UserStateService>().getAvatarList();
    isLoaded.value = true;
  }

  Future<void> selectAvatar(int index) async {
    Get.back<String>(result: avatarList[index]);
  }
}
