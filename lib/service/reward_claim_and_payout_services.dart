import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/exception/content_fetch_exception.dart';
import 'api_service.dart';

class RewardClaimAndPayoutService extends GetxService {
  APIService apiService = Get.put(APIService());

  Future<ApiResponse> withdrawBonk(String walletAddress, int amount) async {
    final ApiResponse response = await apiService.sendWithdrawalRequest(
      '/solana/trans-req-bonk/',
      fields: <String, dynamic>{
        'trans_req_bonk': walletAddress,
        'amount_bonk': amount,
      },
    );

    if (response.statusCode == 200) {
      try {
        debugPrint('Bonk payout service: ${response.message}');
        return response;
      } catch (error) {
        return ApiResponse(
          statusCode: response.statusCode,
          message: 'Error while parsing Payout Service: $error',
          success: response.success,
        );
      }
    } else {
      return ApiResponse(
        statusCode: response.statusCode,
        message: response.message,
        success: response.success,
      );
    }
  }

  Future<String?> claimCourseReward(
    int courseId,
  ) async {
    final ApiResponse response = await apiService.post(
      '/course/reward/claim/$courseId',
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        debugPrint('Claim Reward Service: ${response.message}');
        return response.message;
      } catch (error) {
        throw ContentFetchException(
          'Claim Reward Service - error while parsing Claim Reward Service: $error',
        );
      }
    } else {
      throw ContentFetchException(
        'Claim Reward Service - error while searching for Claim Reward Service',
        response.statusCode,
        response.message,
      );
    }
  }

  Future<ApiResponse> getPayoutMessage(String walletAdress) async {
    final ApiResponse response = await apiService.get(
      '/payment/payreq/$walletAdress',
    );

    if (response.statusCode == 200) {
      try {
        debugPrint('Payout Service: ${response.message}');
        return response;
      } catch (error) {
        return ApiResponse(
          statusCode: response.statusCode,
          message: 'Error while parsing Payout Service: $error',
          success: response.success,
        );
      }
    } else {
      return ApiResponse(
        statusCode: response.statusCode,
        message: response.message,
        success: response.success,
      );
    }
  }

  Future<String?> donateSelectedCharity(
    String charityAddress,
    int satsAmount,
  ) async {
    // Build the request body
    final Map<String, dynamic> requestBody = <String, dynamic>{
      'lightning_address': charityAddress,
      'amount': satsAmount,
    };

    // Send the request
    final ApiResponse response = await apiService.post(
      '/payment/donate/',
      body: requestBody, // Pass the request body
    );

    // Handle the response
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        debugPrint('Donate Charity Service: ${response.message}');
        return response.message;
      } catch (error) {
        throw ContentFetchException(
          'Donate Charity Service - error while parsing response: $error',
        );
      }
    } else {
      throw ContentFetchException(
        'Donate Charity Service - error occurred',
        response.statusCode,
        response.message,
      );
    }
  }

  Future<ApiResponse> redeemNFT(
    String walletAddress,
    int nftNumber,
  ) async {
    final Map<String, dynamic> requestBody = <String, dynamic>{
      'receiver_wallet_address': walletAddress,
      'nft_number': nftNumber,
    };

    final ApiResponse response = await apiService.post(
      '/solana/trans-req-nft/',
      body: requestBody,
    );
    debugPrint('Redeem NFT Service: ${response}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        debugPrint('Redeem NFT Service: ${response.message}');
        return response;
      } catch (error) {
        return ApiResponse(
          statusCode: response.statusCode,
          message: 'Error while parsing Redeem NFT Service: $error',
          success: response.success,
        );
      }
    } else {
      Get.snackbar(
        'Error'.tr,
        'Failed to redeem NFT'.tr,
      );
      debugPrint('Redeem NFT Service Error: ${response.message}');
      return ApiResponse(
        statusCode: response.statusCode,
        message: response.message,
        success: response.success,
      );
    }
  }
}
