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
  final UserStateService userStateService = Get.find<UserStateService>();

  @override
  Future<void> onInit() async {
    loading.value = true;
    super.onInit();
    await checkUserName();
    await userStateService.get();
    await contentService.fetchData();
    // final int solanaCourseCount = contentService.solanaCourseCount.value;

    // firstNftBadgeStatus.value =
    //     contentService.solanaCourseCompletedCount.value >= 2
    //         ? NftBadgeStatus.unlocked
    //         : NftBadgeStatus.locked;
    // secondNftBadgeStatus.value =
    //     contentService.solanaCourseCompletedCount.value >= solanaCourseCount
    //         ? NftBadgeStatus.unlocked
    //         : NftBadgeStatus.locked;
    updateNFTStatus();
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

  void updateNFTStatus() {
    if (userStateService.user.value.nftOne == 'claimed') {
      firstNftBadgeStatus.value = NftBadgeStatus.redeemed;
    } else if (userStateService.user.value.nftOne == 'available') {
      firstNftBadgeStatus.value = NftBadgeStatus.unlocked;
    } else {
      firstNftBadgeStatus.value = NftBadgeStatus.locked;
    }
    if (userStateService.user.value.nftTwo == 'claimed') {
      secondNftBadgeStatus.value = NftBadgeStatus.redeemed;
    } else if (userStateService.user.value.nftTwo == 'available') {
      secondNftBadgeStatus.value = NftBadgeStatus.unlocked;
    } else {
      secondNftBadgeStatus.value = NftBadgeStatus.locked;
    }
  }

  Future<void> redeemNFT(int nftNumber) async {
    PopupManager.openConnectWallet(nftNumber);
  }
}
