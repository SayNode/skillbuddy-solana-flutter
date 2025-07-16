import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../../service/storage/storage_service.dart';
import '../../../service/theme_service.dart';
import '../../../theme/theme.dart';
import '../../../theme/typography.dart';
import '../../../widget/skillbuddy_button.dart';
import '../../token_list/token_list.dart';

class CheckOutRewardsController extends GetxController {
  final RxBool isBannerVisible = true.obs;
}

class CheckOutRewards extends GetView<CheckOutRewardsController> {
  const CheckOutRewards({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CheckOutRewardsController());
    final CustomTheme theme = ThemeService().theme;

    return Obx(() {
      return controller.isBannerVisible.value
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: <Widget>[
                  Transform(
                    transform: Matrix4.translationValues(0, -20, 0),
                    child: SizedBox(
                      width: context.width,
                      child: IconButton(
                        onPressed: () {
                          Get.find<StorageService>()
                              .shared
                              .writeInt('showBonkBanner', 0);
                          controller.isBannerVisible.value = false;
                        },
                        icon: Icon(Icons.close, color: theme.graphite),
                        alignment: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 150,
                          child: RiveAnimation.asset(
                            'asset/animations/solana_animations.riv',
                            artboard: 'Rewards',
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.center,
                            onInit: (Artboard artboard) {
                              final StateMachineController? controller =
                                  StateMachineController.fromArtboard(
                                artboard,
                                'State Machine 1',
                              );
                              if (controller != null) {
                                artboard.addController(controller);
                              }
                            },
                            placeHolder: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: Column(
                            children: <Widget>[
                              AutoSizeText(
                                'Bonk course rewards are here!',
                                textAlign: TextAlign.center,
                                maxLines: 4,
                                style: SkillBuddyTypography.fromColor(
                                  theme.graphite,
                                ).kParagraphSemiBold20,
                              ),
                              const SizedBox(height: 12),
                              SkillBuddyButton(
                                text: 'Show me',
                                padding: 8,
                                onTap: () =>
                                    Get.to<void>(() => const TokenListPage()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const SizedBox();
    });
  }
}
