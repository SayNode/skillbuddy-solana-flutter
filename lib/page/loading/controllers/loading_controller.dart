import 'package:get/get.dart';

class LoadingController extends GetxController {
  LoadingController({this.job});

  final void Function()? job;

  @override
  void onReady() {
    super.onReady();
    job?.call();
  }
}
