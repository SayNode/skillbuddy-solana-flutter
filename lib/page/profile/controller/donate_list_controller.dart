import 'package:get/get.dart';

import '../../../model/charity_model.dart';

class DonateListController extends GetxController {
  // List of charities
  final List<Charity> charities = <Charity>[
    Charity(
      title: 'Human Rights Foundation',
      image: 'asset/icons/human_rights_logo.svg',
      charityAddress: 'hrf@btcpay.hrf.org',
    ),
  ];
}
