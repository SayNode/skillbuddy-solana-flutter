import 'package:get/get.dart';

import '../../../model/content/course.dart';
import '../../../service/content_service.dart';
import '../../../service/user_state_service.dart';
import '../../../util/util.dart';
import '../../../widget/popups/popup_manager.dart';
import '../../explore_course/course_page.dart';
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
    final int solanaCourseCount = contentService.solanaCourseCount.value;
    firstNftBadgeStatus.value =
        contentService.solanaCourseCompletedCount.value >= 2
            ? NftBadgeStatus.unlocked
            : NftBadgeStatus.locked;
    secondNftBadgeStatus.value =
        contentService.solanaCourseCompletedCount.value >= solanaCourseCount
            ? NftBadgeStatus.unlocked
            : NftBadgeStatus.locked;
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
    PopupManager.openConnectWallet(nftNumber);

    // final bool success = await Get.find<RewardClaimAndPayoutService>()
    //     .redeemNFT(userWallet, nftNumber);
    // if (success) {
    //   if (nftNumber == 1) {
    //     firstNftBadgeStatus.value = NftBadgeStatus.redeemed;
    //   } else if (nftNumber == 2) {
    //     secondNftBadgeStatus.value = NftBadgeStatus.redeemed;
    //   }
    // } else {
    //   Get.snackbar(
    //     'Error'.tr,
    //     'Failed to redeem NFT'.tr,
    //   );
    //   if (nftNumber == 1) {
    //     firstNftBadgeStatus.value = NftBadgeStatus.locked;
    //   } else if (nftNumber == 2) {
    //     secondNftBadgeStatus.value = NftBadgeStatus.locked;
    //   }
    // }
  }
}
