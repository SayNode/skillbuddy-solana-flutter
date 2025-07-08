import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/content/lesson_score.dart';
import '../model/exception/content_fetch_exception.dart';
import 'api_service.dart';

class QuizService extends GetxService {
  APIService apiService = Get.put(APIService());

  Future<LessonScore> completeLessonQuiz(
    int lessonId,
    List<int> answerList,
  ) async {
    final ApiResponse response = await apiService.post(
      '/lesson/complete-quiz/$lessonId',
      body: <String, dynamic>{'answers': answerList},
    );

    if (response.statusCode == 200) {
      try {
        debugPrint('completeLessonQuiz: ${response.result}');

        return LessonScore.fromJson(response.result ?? <String, dynamic>{});
      } catch (error) {
        throw ContentFetchException(
          'completeLessonQuiz - error while parsing Lesson score: $error',
        );
      }
    } else {
      throw ContentFetchException(
        'completeLessonQuiz - error while searching for Lesson score',
        response.statusCode,
        response.message,
      );
    }
  }
}
