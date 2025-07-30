import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/content/course.dart';
import '../model/content/lesson.dart';
import '../model/content/module.dart';
import '../model/data_loader.dart';
import '../model/exception/content_fetch_exception.dart';
import '../model/quiz/lesson_quiz.dart';
import 'api_service.dart';
import 'auth_service.dart';
import 'interest_service.dart';

/// needs the secure storage service to be initialized
class ContentService extends GetxService {
  late final DataLoader<List<Course>> myCourses;

  @override
  void onInit() {
    super.onInit();
    myCourses = DataLoader<List<Course>>(
      data: <Course>[].obs,
      loaderCallback: _getUserEnrolledCourses,
    );
    //add listener to myCourses to update courseCompleted
    myCourses.data.listen((_) => coursesCompleted());
  }

  //Services
  AuthService authService = Get.find<AuthService>();
  APIService apiService = Get.put(APIService());

  int coursesCompleted() =>
      myCourses.data.value.where((Course e) => e.isCompleted).length;

  Future<void> fetchData() async => myCourses.reload();

  Future<List<Course>> getSuggestedCourses() async {
    final List<Course> ret = <Course>[];

    final ApiResponse response = await apiService.get('course/suggested/');
    if (response.statusCode == 200) {
      try {
        final List<dynamic>? untypedList = response.results;
        for (int i = 0; i < (untypedList?.length ?? 0); i++) {
          // ignore: avoid_dynamic_calls
          if (untypedList?[i]['areas_of_interest'].contains('Bitcoin (BTC)') ==
              false) {
            final Course course =
                Course.fromJson(untypedList?[i] ?? <String, dynamic>{});
            ret.add(course);
          }
        }
        return ret;
      } catch (error) {
        throw ContentFetchException(
          'getSuggestedCourses - error while parsing Course list: $error',
        );
      }
    } else {
      throw ContentFetchException(
        'getSuggestedCourses - error while searching for Course list',
        response.statusCode,
        response.message,
      );
    }
  }

  Future<Map<AreaOfInterest, List<Course>>> getAllCourses(
    AreasOfInterest interests,
  ) async {
    final InterestService interestService = Get.find<InterestService>();
    final Map<AreaOfInterest, List<Course>> ret =
        <AreaOfInterest, List<Course>>{};
    final ApiResponse response = await apiService.get(
      'course/',
      queryParameters: <String, dynamic>{
        'areas_of_interest': interests.areas
            .where((AreaOfInterest e) => e.title != 'Bitcoin (BTC)')
            .map((AreaOfInterest e) => e.title)
            .join(','),
      },
    );
    if (response.statusCode == 200) {
      try {
        response.result?.forEach((String key, dynamic value) {
          ret[interestService.interestSelection.value.areas.firstWhere(
            (AreaOfInterest e) => e.title == key,
          )] = <Course>[
            for (final dynamic element in value as List<dynamic>)
              Course.fromJson(element),
          ];
        });

        return ret;
      } catch (error) {
        throw ContentFetchException(
          'getAllCourses - error while parsing Course list: $error',
        );
      }
    } else {
      throw ContentFetchException(
        'getAllCourses - error while searching for Course list',
        response.statusCode,
        response.message,
      );
    }
  }

  Future<List<Course>> _getUserEnrolledCourses() async {
    final List<Course> courseList = <Course>[];

    final ApiResponse response = await apiService.get('course/enrolled/');
    if (response.statusCode == 200) {
      try {
        final List<dynamic>? untypedList = response.results;
        for (int i = 0; i < (untypedList?.length ?? 0); i++) {
          final Course course =
              Course.fromJson(untypedList?[i] ?? <String, dynamic>{});
          if (course.activated) {
            courseList.add(course);
          }
        }

        return courseList;
      } catch (error) {
        throw ContentFetchException(
          'getUserEnrolledCourses - error while parsing Course list: $error',
        );
      }
    } else if (response.statusCode == 404) {
      //TODO: handle 404
      return courseList;
    } else {
      throw ContentFetchException(
        'getUserEnrolledCourses - error while searching for Course list',
        response.statusCode,
        response.message,
      );
    }
  }

  Future<List<Course>> getUserEnrolledCoursesForUser(int userId) async {
    final List<Course> courseList = <Course>[];

    final ApiResponse response =
        await apiService.get('course/enrolled/$userId');
    if (response.statusCode == 200) {
      try {
        final List<dynamic> untypedList = response.results ?? <dynamic>[];
        for (int i = 0; i < untypedList.length; i++) {
          final Course course = Course.fromJson(untypedList[i]);
          courseList.add(course);
        }
        return courseList;
      } catch (error) {
        throw ContentFetchException(
          'getUserEnrolledCourses - error while parsing Course list: $error',
        );
      }
    } else if (response.statusCode == 404) {
      return courseList;
    } else {
      throw ContentFetchException(
        'getUserEnrolledCourses - error while searching for Course list',
        response.statusCode,
        response.message,
      );
    }
  }

  Future<CourseModulesTuple> getAllModulesFromCourse(int courseId) async {
    final List<Module> moduleList = <Module>[];
    final ApiResponse response = await apiService.get(
      '/module/$courseId',
    );

    if (response.statusCode == 200) {
      try {
        final Course course = Course.fromJson(response.result?['course']);
        final List<dynamic> untypedList = response.result?['modules'];
        for (int i = 0; i < untypedList.length; i++) {
          final Module chapter = Module.fromJson(untypedList[i]);
          moduleList.add(chapter);
        }
        return CourseModulesTuple(course, moduleList);
      } catch (error) {
        throw ContentFetchException(
          'getAllChapterFromCategory - error while parsing Module list: $error',
        );
      }
    } else {
      throw ContentFetchException(
        'getAllChapterFromCategory - error while searching for Module list',
        response.statusCode,
        response.message,
      );
    }
  }

  Future<Lesson> getLesson(int lessonId) async {
    final ApiResponse response = await apiService.get(
      '/api/class/$lessonId/',
    );

    if (response.statusCode == 200) {
      try {
        return Lesson.fromJson(response.result ?? <String, dynamic>{});
      } catch (error) {
        throw ContentFetchException(
          'getLesson - error while parsing Lesson: $error',
        );
      }
    } else {
      throw ContentFetchException(
        'getLesson - error while searching for Lesson',
        response.statusCode,
        response.message,
      );
    }
  }

  Future<LessonQuiz> getLessonQuiz(int lessonId) async {
    final ApiResponse response = await apiService.get(
      '/lesson/quiz/$lessonId',
    );

    if (response.statusCode == 200) {
      try {
        return LessonQuiz.fromJson(response.results ?? <dynamic>[]);
      } catch (error) {
        throw ContentFetchException(
          'getQuiz - error while parsing Quiz: $error',
        );
      }
    } else {
      throw ContentFetchException(
        'getQuiz - error while searching for Quiz',
        response.statusCode,
        response.message,
      );
    }
  }

  Future<bool> enrollCourse(int courseId) async {
    final ApiResponse response = await apiService.post(
      '/course/enroll/$courseId',
    );
    if (response.statusCode == 201) {
      debugPrint('Course enrolled');
      return true;
    } else if (response.statusCode == 200) {
      debugPrint('Course already enrolled');
      return true;
    } else {
      debugPrint('Course not enrolled');
      return false;
    }
  }

  Future<bool> unenrollCourse(int courseId) async {
    myCourses.data.value
        .removeWhere((Course element) => element.id == courseId);
    final ApiResponse response = await apiService.post(
      '/course/unenroll/$courseId',
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      debugPrint('Course unenrolled');
      return true;
    } else {
      debugPrint('Course not unenrolled');
      return false;
    }
  }

  Future<bool> resetProgress(int courseId) async {
    final ApiResponse response = await apiService.post(
      '/course/reset-progress/$courseId',
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      debugPrint('Course progress reset');
      return true;
    } else {
      debugPrint('Course progress not reset');
      return false;
    }
  }

  Future<NextStep?> courseNextStep(int courseId) async {
    final ApiResponse response = await apiService.get(
      '/course/$courseId/retrieve-next-steps/',
    );
    if (response.success) {
      log('Course next step: ${response.result}');
      final Map<String, dynamic> data = response.result?['data'];
      return NextStep.fromJson(data);
    } else {
      return null;
    }
  }
}

class CourseModulesTuple {
  CourseModulesTuple(this.course, this.modules);

  final Course course;
  final List<Module> modules;
}
