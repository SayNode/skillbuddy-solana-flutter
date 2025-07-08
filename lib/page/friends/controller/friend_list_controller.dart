import 'package:get/get.dart';

import '../../../model/user_model.dart';
import '../../../service/user_state_service.dart';

class FriendListController extends GetxController {
  RxList<dynamic> friendsList = <dynamic>[].obs;

  // List<dynamic> friendsList = Get.find<UserStateService>().user.value.following;
  @override
  void onInit() {
    refreshFriendsList();
    super.onInit();
  }

  void refreshFriendsList() {
    final User user = Get.find<UserStateService>().user.value;
    friendsList.value = user.following;
  }
}
