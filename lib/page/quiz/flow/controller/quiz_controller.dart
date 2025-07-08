import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/content/chapter.dart';
import '../../../../model/content/course.dart';
import '../../../../model/content/lesson.dart';
import '../../../../model/content/lesson_score.dart';
import '../../../../model/content/module.dart';
import '../../../../model/quiz/lesson_answer.dart';
import '../../../../model/quiz/lesson_quiz.dart';
import '../../../../service/quiz_service.dart';
import '../../../loading/loading_page.dart';
import '../../results/quiz_results_page.dart';

enum QuizQuestionStatus {
  current,
  upcoming,
  correct,
  incorrect,
}

enum QuizAnswerStatus {
  neutral,
  selected,
  validating,
  correct,
  incorrect,
}

class QuizController extends GetxController {
  QuizController({
    required this.quiz,
    required this.course,
    required this.module,
    required this.lesson,
    required this.chapter,
  });
  late final Course course;
  late final Module module;
  late final Chapter chapter;
  late final LessonQuiz quiz;
  late final Lesson lesson;
  RxList<QuizQuestionStatus> questionStatus = <QuizQuestionStatus>[].obs;
  RxList<QuizAnswerStatus> answerStatus = <QuizAnswerStatus>[].obs;
  RxInt currentQuestion = 0.obs;
  RxBool validating = false.obs;
  RxInt selectedIndex = (-1).obs;
  Rx<QuizAnswerStatus> quizAnswerStatus = QuizAnswerStatus.neutral.obs;

  RxMap<int, int> answerIds = <int, int>{}.obs;

  final QuizService quizService = Get.put(QuizService());

  // Add ScrollController and itemKeys
  final ScrollController scrollController = ScrollController();
  List<GlobalKey> itemKeys = <GlobalKey<State<StatefulWidget>>>[];

  final RxString feedbackMessage = ''.obs;
  final List<String> positiveFeedbackMessages = <String>[
    'Spot on! Great job.',
    "Correct! You're on a roll.",
    'Perfect! Keep up the good work.',
    "That's right! You've got this.",
  ];
  final List<String> negativeFeedbackMessages = <String>[
    'Not quite.',
    'Close, but not correct.',
    'Good try!',
    "Oops, that's not it.",
  ];
  String get positiveFeedback => positiveFeedbackMessages[Random().nextInt(4)];
  String get negativeFeedback => negativeFeedbackMessages[Random().nextInt(4)];

  @override
  void onInit() {
    super.onInit();

    // Initialize questionStatus and answerStatus as before
    if (quiz.questionList.isNotEmpty) {
      questionStatus
        ..add(QuizQuestionStatus.current)
        ..addAll(
          List<QuizQuestionStatus>.generate(
            quiz.questionList.length - 1,
            (int index) => QuizQuestionStatus.upcoming,
          ),
        );
    }
    // Create list of answer status -> [neutral, neutral, ...]
    answerStatus.addAll(
      List<QuizAnswerStatus>.generate(
        quiz.questionList[currentQuestion.value].answers.length,
        (int index) => QuizAnswerStatus.neutral,
      ),
    );

    // Initialize itemKeys based on questionStatus length
    itemKeys = List<GlobalKey>.generate(
      questionStatus.length,
      (int index) => GlobalKey(),
    );

    // Listen to changes in currentQuestion
    ever(currentQuestion, (_) {
      scrollToCurrentQuestion();
    });
  }

  // Helper method to scroll to current question
  void scrollToCurrentQuestion() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (itemKeys[currentQuestion.value].currentContext != null) {
        Scrollable.ensureVisible(
          itemKeys[currentQuestion.value].currentContext!,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.5, // Adjust as needed
        );
      }
    });
  }

  // Future<void> select(int i, {required bool isCorrect}) async {
  //   // Record answer in backend
  //   await quizService.addLessonQuizRecord(
  //     quiz.questionList[currentQuestion.value].id,
  //     quiz.questionList[currentQuestion.value].answers[i].id,
  //   );
  //   validating.value = true;
  //   answerStatus[i] = QuizAnswerStatus.validating;
  // }

  Future<void> onValidated(int i, {required bool isCorrect}) async {
    answerStatus[i] =
        isCorrect ? QuizAnswerStatus.correct : QuizAnswerStatus.incorrect;
    questionStatus[currentQuestion.value] =
        isCorrect ? QuizQuestionStatus.correct : QuizQuestionStatus.incorrect;
    if (!isCorrect) {
      final int correct =
          quiz.questionList[currentQuestion.value].answers.indexWhere(
        (dynamic element) => (element as LessonAnswer).answerCorrect == true,
      );
      answerStatus[correct] = QuizAnswerStatus.correct;
    }
    validating.value = false;
  }

  Future<void> next({required bool isCorrect}) async {
    feedbackMessage.value = '';
    if (currentQuestion.value < quiz.questionList.length - 1) {
      currentQuestion.value++;
      questionStatus[currentQuestion.value] = QuizQuestionStatus.current;
      answerStatus
        ..clear()
        ..addAll(
          List<QuizAnswerStatus>.generate(
            quiz.questionList[currentQuestion.value].answers.length,
            (int index) => QuizAnswerStatus.neutral,
          ),
        );
    } else {
      await Get.off<void>(
        () => LoadingPage(
          title: 'Completing Quiz...',
          job: () async {
            // End Lesson in backend
            // generate a list of answerIds values, ordered by their repective keys
            final List<int> valuesSortedByKey = answerIds.keys.toList()..sort();
            final LessonScore score = await quizService.completeLessonQuiz(
              lesson.id,
              valuesSortedByKey.map((int key) => answerIds[key]!).toList(),
            );
            await Get.off<void>(
              () => QuizResultsPage(
                correctAnswers: questionStatus
                    .where(
                      (QuizQuestionStatus p0) =>
                          p0 == QuizQuestionStatus.correct,
                    )
                    .length,
                answersAmount: questionStatus.length,
                score: score,
                lastLesson: chapter.lessons.indexOf(lesson) ==
                    chapter.lessons.length - 1,
                course: course,
                module: module,
                chapter: chapter,
                lesson: lesson,
              ),
            );
          },
        ),
      );
    }
  }

  Future<void> onTapToProceed() async {
    if (quizAnswerStatus.value == QuizAnswerStatus.neutral) {
      return;
    }
    final QuizAnswerStatus tempStatus = quizAnswerStatus.value;
    quizAnswerStatus.value = QuizAnswerStatus.neutral;
    switch (tempStatus) {
      case QuizAnswerStatus.correct:
        await next(isCorrect: true);
      case QuizAnswerStatus.incorrect:
        await next(isCorrect: false);
      // ignore: no_default_cases
      default:
        return;
    }
  }

  Future<void> onConfirmAnswer() async {
    final int i = selectedIndex.value;
    final LessonAnswer selectedAnswer =
        quiz.questionList[currentQuestion.value].answers[i];
    validating.value = true;
    answerStatus[i] = QuizAnswerStatus.validating;
    selectedIndex.value = -1;

    answerIds[quiz.questionList[currentQuestion.value].id] = selectedAnswer.id;

    final bool isCorrect = selectedAnswer.answerCorrect;

    await Future<void>.delayed(const Duration(milliseconds: 400))
        .then((_) async {
      await onValidated(i, isCorrect: isCorrect);
      if (isCorrect) {
        quizAnswerStatus.value = QuizAnswerStatus.correct;
        feedbackMessage.value = positiveFeedback;
      } else {
        quizAnswerStatus.value = QuizAnswerStatus.incorrect;
        feedbackMessage.value = negativeFeedback;
      }
    });
  }

  Future<void> onAnswerTap(int i) async {
    if (validating.value ||
        quizAnswerStatus.value == QuizAnswerStatus.correct ||
        quizAnswerStatus.value == QuizAnswerStatus.incorrect) {
      return;
    }
    quizAnswerStatus.value = QuizAnswerStatus.selected;
    if (selectedIndex.value != -1) {
      answerStatus[selectedIndex.value] = QuizAnswerStatus.neutral;
    }
    selectedIndex.value = i;
    answerStatus[i] = QuizAnswerStatus.selected;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
