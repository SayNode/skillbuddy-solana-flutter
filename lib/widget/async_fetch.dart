import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../page/error/error_page.dart';
import '../service/user_state_service.dart';

class AsyncFetch extends StatelessWidget {
  const AsyncFetch({
    required this.futures,
    required this.success,
    super.key,
    this.error,
    this.loading,
  });
  final Iterable<Future<dynamic>> futures;
  final dynamic Function(BuildContext context, List<dynamic>) success;
  final Widget? error;
  final Widget? loading;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait(futures),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loading ??
              const Center(
                child: CircularProgressIndicator(),
              );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            final Object? error = snapshot.error;
            final StackTrace? stackTrace = snapshot.stackTrace;

            // Define additional information here
            final List<String> additionalInfo = <String>[
              'Current Route: ${Get.currentRoute}',
              'User Id: ${Get.put(UserStateService()).user.value.id}',
            ];

            // Record the error with additional information
            FirebaseCrashlytics.instance.recordError(
              error,
              stackTrace,
              fatal: true,
              information: additionalInfo,
            );

            return ErrorPage(error: error ?? 'An unknown error occurred.');
          } else if (snapshot.hasData) {
            return success(context, snapshot.data!);
          }
        }
        return error ?? ErrorPage(error: error ?? 'An unknown error occurred.');
      },
    );
  }
}
