import 'package:flutter/material.dart';

import '../../../model/content/chapter.dart';
import '../../../model/content/course.dart';
import '../../../model/content/lesson.dart';
import '../../../model/content/lesson_score.dart';
import '../../../model/content/module.dart';
import 'quiz_failed_page.dart';
import 'quiz_passed_page.dart';

class QuizResultsPage extends StatelessWidget {
  const QuizResultsPage({
    required this.course,
    required this.module,
    required this.chapter,
    required this.lesson,
    required this.correctAnswers,
    required this.answersAmount,
    required this.score,
    required this.lastLesson,
    super.key,
  });
  final Course course;
  final Module module;
  final Chapter chapter;
  final Lesson lesson;
  final int correctAnswers;
  final int answersAmount;
  final LessonScore score;
  final bool lastLesson;

  @override
  Widget build(BuildContext context) {
    return score.lessonPassed
        ? (QuizPassedPage(
            course: course,
            module: module,
            chapter: chapter,
            lesson: lesson,
            correctAnswers: correctAnswers,
            answersAmount: answersAmount,
            score: score,
            lastLesson: lastLesson,
          ))
        : QuizFailedPage(
            chapter: chapter,
            lesson: lesson,
            correctAnswers: correctAnswers,
            answersAmount: answersAmount,
            score: score,
            course: course,
            module: module,
            lastLesson: lastLesson,
          );
  }
}
