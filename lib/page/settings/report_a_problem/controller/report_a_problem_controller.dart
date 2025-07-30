import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../model/user_model.dart';
import '../../../../service/contact_support_service.dart';
import '../../../../service/theme_service.dart';
import '../../../../service/user_state_service.dart';

class ReportAProblemController extends GetxController {
  TextEditingController textController = TextEditingController();
  RxBool textValid = false.obs;
  Rxn<Uint8List> photoBytes = Rxn<Uint8List>();
  final ImagePicker picker = ImagePicker();
  final Rx<User> user = Get.find<UserStateService>().user;
  ThemeService themeService = Get.find<ThemeService>();
  File? photoPath;
  void validateText(String text) {
    textValid.value = text.isNotEmpty;
  }

  Future<void> addPhoto() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1800,
      maxWidth: 1800,
    );
    if (pickedFile != null) {
      final File rotatedFile = await FlutterExifRotation.rotateImage(
        path: pickedFile.path,
      );
      photoPath = await _compressFile(rotatedFile.path);
      photoBytes.value = await photoPath!.readAsBytes();
    }
  }

  Future<File> _compressFile(String filePath) async {
    final File file = File(filePath);
    final Uint8List? result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minHeight: 1800,
      minWidth: 1800,
      quality: 80,
    );
    final File compressedFile = await file.writeAsBytes(result!);
    return compressedFile;
  }

  Future<void> openDiscordWebsite() async {
    final Uri uri = Uri.parse('https://discord.com/invite/v7Su8qYSuF');

    try {
      await launchUrl(uri);
    } catch (e) {
      // Handle the error if the URL can't be launched
      Get.snackbar(
        'Error',
        'Could not open the link.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> submit() async {
    final String text = textController.text;
    // final Uint8List? photo = photoBytes.value;
    try {
      await Get.put(ContactSupportService()).contactSupport(
        email: user.value.email,
        name: user.value.name,
        message: text,
        image: photoPath,
      );
      Get.snackbar(
        backgroundColor: themeService.theme.seashell,
        'Success',
        'Report submitted successfully',
        snackPosition: SnackPosition.BOTTOM,
        colorText: themeService.theme.graphite,
      );
    } catch (e) {
      // Handle the error
      Get.snackbar(
        backgroundColor: themeService.theme.seashell,
        'Error',
        'Failed to submit the report: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
