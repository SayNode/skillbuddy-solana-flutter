import 'package:get/get.dart';

import '../../../model/content/course.dart';
import '../../../service/content_service.dart';
import '../../../service/reward_claim_and_payout_services.dart';
import '../../../service/user_state_service.dart';
import '../../../util/util.dart';
import '../../../widget/popups/popup_manager.dart';
import '../../explore_course/course_page.dart';
import '../../solana/solana_service.dart';
import '../widget/nft_badge_card.dart';

class ProfileController extends GetxController {
  late RxBool seeMore = false.obs;
  RxBool loading = false.obs;
  Rx<NftBadgeStatus> firstNftBadgeStatus = NftBadgeStatus.locked.obs;
  Rx<NftBadgeStatus> secondNftBadgeStatus = NftBadgeStatus.locked.obs;
  //Services
  final ContentService contentService = Get.find<ContentService>();

  @override
  Future<void> onInit() async {
    loading.value = true;
    super.onInit();
    await checkUserName();
    await Get.find<UserStateService>().get();
    await contentService.fetchData();
    loading.value = false;
  }

  void toggleSeeMore() {
    seeMore.value = !seeMore.value;
  }

  Future<void> goToCourseDetails(
    Course course, {
    bool autoOpenFirstLesson = false,
  }) async {
    // ignore: inference_failure_on_function_invocation
    await Get.to(
      () => CoursePage(
        courseId: course.id,
        autoOpenFirstLesson: autoOpenFirstLesson,
      ),
    );
  }

  Future<void> redeemNFT(int nftNumber) async {
    // chceck if user has wallet connected
    final String? userWallet = Get.find<SolanaService>().walletAddress.value;
    if (userWallet != null && userWallet.isNotEmpty) {
      await Get.find<RewardClaimAndPayoutService>()
          .redeemNFT(userWallet, nftNumber);
      // PopupManager.openPayoutPopup();
    } else {
      PopupManager.openPayoutPopup();
    }
  }
}
