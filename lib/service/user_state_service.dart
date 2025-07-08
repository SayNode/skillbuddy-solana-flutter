import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// For MediaType

import '../model/last_visited_lesson.dart';
import '../model/user_model.dart';
import 'api_service.dart';
import 'storage/storage_service.dart';

class UserStateService extends GetxService {
  Rx<User> user = User().obs;
  final StorageService storageService = Get.find<StorageService>();

  final String LAST_COURSE_ID = 'last_course_id';
  final String LAST_MODULE_ID = 'last_module_id';
  final String LAST_CHAPTER_ID = 'last_chapter_id';
  final String LAST_LESSON_ID = 'last_lesson_id';

  void saveLastVisitedLesson(LastVisitedLesson lastVisitedLesson) {
    storageService.shared.writeInt(LAST_COURSE_ID, lastVisitedLesson.courseId);
    storageService.shared
        .writeInt(LAST_MODULE_ID, lastVisitedLesson.moduleSequence);
    storageService.shared
        .writeInt(LAST_CHAPTER_ID, lastVisitedLesson.chapterId);
    storageService.shared.writeInt(LAST_LESSON_ID, lastVisitedLesson.lessonId);
  }

  LastVisitedLesson loadLastVisitedLesson() {
    final int courseId = storageService.shared.readInt(LAST_COURSE_ID) ?? 0;
    final int moduleId = storageService.shared.readInt(LAST_MODULE_ID) ?? 0;
    final int chapterId = storageService.shared.readInt(LAST_CHAPTER_ID) ?? 0;
    final int lessonId = storageService.shared.readInt(LAST_LESSON_ID) ?? 0;
    return LastVisitedLesson(
      courseId: courseId,
      moduleSequence: moduleId,
      chapterId: chapterId,
      lessonId: lessonId,
    );
  }

  void clear() {
    user.value = User();
  }

  Future<void> get() async {
    final ApiResponse response = await Get.find<APIService>().get('users');
    if (response.result != null) {
      user
        ..value = User.fromJson(response.result!)
        ..refresh();
    }
  }

  Future<List<String>> getAvatarList() async {
    final ApiResponse response =
        await Get.find<APIService>().get('/users/get-avatars/');
    if (response.success) {
      if (response.results != null) {
        return List<String>.from(response.results!);
      }
      return <String>[];
    } else {
      throw Exception('Error fetching avatar list - ${response.result}, ');
    }
  }

  Future<void> update({
    String? userName,
    String? bio,
    String? avatar,
    String? firebasePushNotificationToken,
    List<String>? areasOfInterest,
    int? timeGrowingDaily,
    int? dailyStreak,
    int? xp,
  }) async {
    List<http.MultipartFile>? files;
    final Map<String, dynamic> body = <String, dynamic>{
      'name': userName,
      'bio': bio,
      'firebase_push_notification_token': firebasePushNotificationToken,
      'areas_of_interest': areasOfInterest,
      'time_growing_daily': timeGrowingDaily,
      'daily_streak': dailyStreak,
      'xp': xp,
      'avatar_url': avatar,
    }..removeWhere(
        (dynamic key, dynamic value) => key == null || value == null,
      );

    final ApiResponse response = await Get.find<APIService>().patch(
      'users/update-user/',
      body: body.isNotEmpty ? body : null,
      files: files, // Pass the files to the put method
    );

    if (response.result != null) {
      user.value = User.fromJson(response.result!);
    }
  }

  Future<void> verification() async {
    final ApiResponse response =
        await Get.find<APIService>().post('users/verify/');
    if (response.result != null) {
      Get.snackbar('Verification'.tr, 'Verification link sent to email'.tr);
    }
  }
}
