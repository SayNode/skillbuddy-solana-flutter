// ignore_for_file: inference_failure_on_function_invocation

import '../../model/content/course.dart';
import '../../page/profile/widget/nft_badge_card.dart';
import '../skillbuddy_popup.dart';
import 'company_profile.dart';
import 'course_added_popup.dart';
import 'donate_popup.dart';
import 'donate_success_popup.dart';
import 'loading_payout_popup.dart';
import 'payout_popup.dart';
import 'redeem_ntf_popup.dart';
import 'successful_message_popup.dart';
import 'tenent_delete_popup.dart';
import 'verify_popup.dart';

class PopupManager {
  static void openPayoutPopup() {
    openSkillBuddyPopup(
      const PayoutPopup(),
    );
  }

  static void donatePayoutPopup({required String charityAddress}) {
    openSkillBuddyPopup(
      DonatePopup(
        charityAddress: charityAddress,
      ),
    );
  }

  static void donatePayoutSuccessPopup() {
    openSkillBuddyPopup(
      const DonatePayoutSuccessPopup(),
    );
  }

  static void openPayoutWallet() {
    openSkillBuddyPopup(
      const VerifyPopup(),
    );
  }

  static void openConnectWallet(int nftNumber, NftBadgeStatus status) {
    openSkillBuddyPopup(
      RedeemNFTPopup(nftNumber: nftNumber, status: status),
    );
  }

  static void openSuccessPopup() {
    openSkillBuddyPopup(
      const SuccessfulPopup(),
    );
  }

  static void openLoadingPopup({String? title}) {
    openSkillBuddyPopup(
      closeButton: false,
      title != null ? LoadingPopup(title: title) : const LoadingPopup(),
    );
  }

  static void openCompanyInfoPopup(Course course) {
    openSkillBuddyPopup(
      CompanyInfoPopup(
        course: course,
      ),
    );
  }

  static Future<void> openCourseAddedPopup({required int courseId}) async {
    await openSkillBuddyPopup(
      CourseAddedPopup(
        courseId: courseId,
      ),
    );
  }

  static void openTenentAccountDeletePopup() {
    openSkillBuddyPopup(
      const TenantAccountDeletePopup(),
    );
  }
}
