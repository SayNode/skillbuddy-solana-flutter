import 'package:get/get.dart';

import '../../../model/charity_model.dart';

class DonateListController extends GetxController {
  // List of charities
  final List<Charity> charities = <Charity>[
    Charity(
      title: 'Dolphin Project',
      image: 'asset/images/dolphin_project.png',
      charityAddress: 'DseusjU6osBZ3Q3L2z7Uq5cUewht2y3UstVV7daXMCnc',
    ),
  ];
}
