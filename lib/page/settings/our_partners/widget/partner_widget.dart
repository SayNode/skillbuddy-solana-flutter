import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/util.dart';

class PartnerWidget extends StatelessWidget {
  const PartnerWidget({
    required this.imagePath,
    super.key,
  });
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    //final Size screenSize = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          imagePath,
          width: getRelativeWidth(60),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getRelativeWidth(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Yzer is an all-in-one app to learn about Bitcoin, blockchain, and more. Access educational content, market analysis, and practical guides. Stay informed with real-time news and join a supportive community. Enhance your cryptocurrency knowledge easily with Yzer.'
                      .tr,
                  style: const TextStyle(fontSize: 10),
                  softWrap: true,
                ),
                Text(
                  'Visit website: yzer.io'.tr,
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
