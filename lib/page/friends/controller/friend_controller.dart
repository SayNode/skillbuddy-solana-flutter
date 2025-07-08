import 'package:get/get.dart';

import '../../../model/content/course.dart';
import '../../../model/user_model.dart';
import '../../../service/content_service.dart';
import '../../../service/follow_service.dart';
import '../../../service/user_state_service.dart';
import '../../leaderboard/controller/leaderboard_controller.dart';

class FriendController extends GetxController {
  FriendController({required this.user});
  final User? user;
  RxBool loading = false.obs;

  late RxBool seeMore = false.obs;

  late RxList<Course> visibleList = <Course>[].obs;

  RxList<Course> coursesEnrolled = <Course>[].obs;
  RxInt coursesCompleted = (-1).obs;
  late RxBool isFollowing = false.obs;
  RxString message = ''.obs;
  @override
  Future<void> onInit() async {
    loading.value = true;
    super.onInit();
    await fetchData();
    // Dynamically set the `isFollowing` value based on the `user.following` list
    final List<dynamic> loginUserFollowingList =
        Get.find<UserStateService>().user.value.following;
    isFollowing.value = loginUserFollowingList.any(
      (dynamic followingUser) =>
          (followingUser as Map<String, dynamic>)['id'] == user!.id,
    );

    loading.value = false;
  }

  Future<void> fetchData() async {
    coursesEnrolled.clear();
    final List<Course> courses = await Get.find<ContentService>()
        .getUserEnrolledCoursesForUser(user!.id);
    coursesEnrolled.assignAll(courses);

    coursesCompleted.value =
        coursesEnrolled.where((Course e) => e.isCompleted).length;
    updateVisibleList();
  }

  void updateVisibleList() {
    if (coursesEnrolled.isEmpty) {
      visibleList = <Course>[].obs;
    }
    visibleList = seeMore.value
        ? coursesEnrolled
        : List<Course>.from(coursesEnrolled.take(4)).toList().obs;
  }

  void toggleSeeMore() {
    seeMore.value = !seeMore.value;
    updateVisibleList();
  }

//   Function to toggle followers
  Future<void> toggleFollowers(int userId) async {
    isFollowing.value = !isFollowing.value;
    await Get.put(FollowService()).followToggle(userId);
    await Get.find<UserStateService>().get();
    await Get.find<LeaderboardController>().refreshLeaderboard();
  }
}
