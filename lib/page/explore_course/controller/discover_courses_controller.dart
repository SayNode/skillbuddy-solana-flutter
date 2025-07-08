import 'dart:math';

import 'package:get/get.dart';

import '../../../model/content/course.dart';
import '../../../model/last_visited_lesson.dart';
import '../../../service/content_service.dart';
import '../../../service/interest_service.dart';
import '../../../service/logger_service.dart';
import '../../../service/user_state_service.dart';
import '../course_page.dart';

class DiscoverCoursesController extends GetxController {
  final RxInt _areaOfInterestIndex = 0.obs;
  final InterestService interestService = Get.find<InterestService>();
  RxList<String> areaOfInterestChips = <String>[].obs;
  RxList<Course> suggestions = <Course>[].obs;
  RxMap<AreaOfInterest, List<Course>> allCourses =
      <AreaOfInterest, List<Course>>{}.obs;
  RxMap<AreaOfInterest, List<Course>> filteredCourses =
      <AreaOfInterest, List<Course>>{}.obs;

  RxBool loading = false.obs;
  ContentService contentService = Get.put(ContentService());
  RxString searchText = ''.obs;

  Rx<LastVisitedLesson?> lastVisitedLesson = Rx<LastVisitedLesson?>(null);
  Rx<Course?> lastVisitedCourse = Rx<Course?>(null);
  UserStateService userStateService = Get.find<UserStateService>();

  @override
  Future<void> onInit() async {
    super.onInit();
    await interestService.waitUntilReady();
    areaOfInterestChips.value = <String>[
      'All Courses',
      ...interestService.interestSelection.value.areas
          .map((AreaOfInterest e) => e.title),
    ];
    await userStateService.get();
    await refreshCourses();
    super.onInit();
  }

  Future<void> refreshCourses() async {
    await fetchAll();
    lastVisitedLesson.value =
        Get.find<UserStateService>().loadLastVisitedLesson();
    if (lastVisitedLesson.value != null) {
      try {
        lastVisitedCourse.value =
            allCourses.values.expand((List<Course> list) => list).singleWhere(
                  (Course course) =>
                      course.id == lastVisitedLesson.value!.courseId,
                );
      } catch (e) {
        lastVisitedCourse.value = null;
        Get.find<LoggerService>().log(e.toString());
      }
    }
  }

  String get greetingMessage {
    final String name = userStateService.user.value.name;
    final int nowHour = DateTime.now().hour;
    final List<String> variations;

    if (nowHour >= 5 && nowHour < 12) {
      variations = <String>[
        'Good morning $name',
        'Hey early bird $name',
        'Rise and shine, $name!',
        'Guess who’s back: $name',
        'Carpe diem $name',
        'Ahoi $name',
        'Hoi $name',
      ];
    } else if (nowHour >= 12 && nowHour < 18) {
      variations = <String>[
        'Good day $name',
        'How was lunch $name?',
        'Still going strong, $name!',
        'Salut $name',
        'Good to see you $name',
        'Hi there',
        'You’ve got the power, $name',
      ];
    } else if (nowHour >= 18 && nowHour < 23) {
      variations = <String>[
        'Good evening $name',
        'Evening vibes, $name!',
        'Late login, $name?',
        'I see you, $name',
        'Houston, $name has landed!',
        'Welcome back, my preciousss $name',
      ];
    } else {
      variations = <String>[
        'Late login, $name?',
        'I see you, $name',
        'Houston, $name has landed!',
        'Welcome back, my preciousss $name',
      ];
    }

    return variations[Random().nextInt(variations.length)];
  }

  void updateSearchText(String value) {
    searchText.value = value;
    filterCourses();
  }

  set coursesIndex(int index) {
    _areaOfInterestIndex.value = index;
  }

  int get coursesIndex => _areaOfInterestIndex.value;

  Future<void> selectAreaOfInterest(int i) async {
    searchText.value = '';
    _areaOfInterestIndex.value = i;
    loading.value = true;
    await fetchAllCourses();
    loading.value = false;
  }

  void goToCourseDetails(
    Course course, [
    LastVisitedLesson? lastVisitedLesson,
  ]) {
    Get.to<void>(
      () => CoursePage(
        courseId: course.id,
        lastVisitedLesson: lastVisitedLesson,
      ),
    )?.then((_) {
      refreshCourses();
    });
  }

  void onFavoriteTap(Course course) {
    // TODO: Implement favorite tap with backend
    //print('Favorite tapped for ${course.id}');
  }

  Future<void> fetchAll() async {
    loading.value = true;
    await fetchSuggestions();
    await fetchAllCourses();
    loading.value = false;
  }

  Future<void> fetchSuggestions() async {
    suggestions.value = await contentService.getSuggestedCourses();
  }

  Future<void> fetchAllCourses() async {
    if (_areaOfInterestIndex.value == 0) {
      allCourses.value = await contentService
          .getAllCourses(interestService.interestSelection.value);
      filterCourses();
    } else {
      allCourses.value = await contentService.getAllCourses(
        AreasOfInterest(
          areas: <AreaOfInterest>[
            interestService
                .interestSelection.value.areas[_areaOfInterestIndex.value - 1],
          ],
        ),
      );
      filterCourses();
    }
  }

  void filterCourses() {
    final String query = searchText.value.trim().toLowerCase();

    if (query.isEmpty) {
      filteredCourses.value =
          Map<AreaOfInterest, List<Course>>.from(allCourses);
    } else {
      final Map<AreaOfInterest, List<Course>> tempFilteredCourses =
          <AreaOfInterest, List<Course>>{};

      // Set a minimum length for the search query
      const int minSearchLength = 2;
      if (query.length < minSearchLength) {
        // If search query is too short, show all courses
        filteredCourses.value =
            Map<AreaOfInterest, List<Course>>.from(allCourses);
        return;
      }

      allCourses.forEach((AreaOfInterest area, List<Course> courses) {
        final List<Course> filteredList = courses.where((Course course) {
          final String courseName = course.name.toLowerCase();
          // Check if the course name contains the search query as a substring
          return courseName.contains(query);
        }).toList();

        if (filteredList.isNotEmpty) {
          tempFilteredCourses[area] = filteredList;
        }
      });

      filteredCourses.value = tempFilteredCourses;
    }
  }
}
