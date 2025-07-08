import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../model/exception/content_fetch_exception.dart';
import 'api_service.dart';

class ContactSupportService extends GetxService {
  APIService apiService = Get.put(APIService());
  Future<void> contactSupport({
    required String email,
    required String name,
    required String message,
    File? image,
  }) async {
    final List<http.MultipartFile> files = <http.MultipartFile>[];
    if (image != null) {
      final String mimeType =
          lookupMimeType(image.path) ?? 'application/octet-stream';
      final http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath(
        'image', // The field name on the server
        image.path,
        contentType: MediaType.parse(mimeType),
      );
      files.add(multipartFile);
    }

    final ApiResponse response = await apiService.post(
      '/subscribe/contact-support',
      body: <String, dynamic>{
        'email': email,
        'name': name,
        'message': message,
      },
      files: files,
    );

    if (response.statusCode == 201) {
      try {
        debugPrint('Support message sent: ${response.result}');
      } catch (error) {
        throw ContentFetchException(
          'Error while sending support message: $error',
        );
      }
    } else {
      throw ContentFetchException(
        'Error while sending support message',
        response.statusCode,
        response.message,
      );
    }
  }
}
