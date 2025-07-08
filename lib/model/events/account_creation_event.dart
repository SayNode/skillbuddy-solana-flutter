import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

import 'skillbuddy_event.dart';

class AccountCreationEvent implements SkillBuddyEvent {
  AccountCreationEvent(
    this.userId,
    this.username,
    this.userEmail,
    this.userAuthenticationMethod,
  );

  final String userId;
  final String username;
  final String userEmail;
  final String userAuthenticationMethod;

  @override
  String get googleToken => GoogleEventToken.accountCreation;

  @override
  BranchStandardEvent? get branchStandardToken =>
      BranchStandardEvent.COMPLETE_REGISTRATION;

  @override
  String? get branchCustomEvent => null;

  @override
  bool get isAutoTrackedByGoogle => false;

  @override
  Map<String, Object> getParameters() {
    return <String, Object>{
      EventParameterId.userId: userId,
      EventParameterId.username: username,
      EventParameterId.userEmail: userEmail,
      EventParameterId.userAuthenticationMethod: userAuthenticationMethod,
    };
  }
}
