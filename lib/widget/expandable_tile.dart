import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/theme_service.dart';
import '../theme/theme.dart';
import '../util/util.dart';

class ExpandableTile extends StatelessWidget {
  const ExpandableTile({
    required this.header,
    required this.body,
    required this.padding,
    super.key,
  });

  final Widget header;
  final Widget body;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Get.put(ThemeService()).theme;

    final RxBool expanded = false.obs;
    return Obx(
      () => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => expanded.value = !expanded.value,
          child: Padding(
            padding: padding,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    getRelativeWidth(9),
                    getRelativeHeight(9),
                    getRelativeWidth(9),
                    getRelativeHeight(9),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: header),
                      AnimatedRotation(
                        turns: expanded.value ? 0.5 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: Icon(
                          Icons.expand_more,
                          color: theme.graphite,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: expanded.value
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              getRelativeWidth(9),
                              0,
                              getRelativeWidth(9),
                              getRelativeHeight(9),
                            ),
                            child: body,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
