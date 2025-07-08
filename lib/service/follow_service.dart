import 'package:get/get.dart';

import 'api_service.dart';

class FollowService {
  Future<String?> followToggle(int userId) async {
    try {
      final ApiResponse response = await Get.find<APIService>().post(
        '/friends/follow/',
        body: <String, dynamic>{'user_id': userId},
      );

      if (response.statusCode == 200) {
        // Assuming the response data contains a 'message' field
        return response.message;
      } else {
        // Handle other status codes or error responses
        throw Exception('Error: ${response.message}');
      }
    } catch (e) {
      // Handle network or parsing errors
      throw Exception('Failed to toggle follow: $e');
    }
  }
}
