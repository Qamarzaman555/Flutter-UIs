import 'package:practice/easy_paisa/Models/easypaisa_model.dart';
import 'package:practice/easy_paisa/test_folders/test1.dart';
import 'package:practice/easy_paisa/test_folders/test2.dart';
import 'package:practice/ui_kit/local_pub.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

class EasyPaisaViewModel extends BaseViewModel {
  int selectedPage = 0;
  PageController? pageController;

  onGetPageController() {
    pageController = PageController(initialPage: 0);
  }

  List<EasyPaisaCard> easypaisaCards = [
    EasyPaisaCard(name: 'Send Money', icon: Icons.send_to_mobile_outlined),
    EasyPaisaCard(name: 'Bill Payment', icon: Icons.payment),
    EasyPaisaCard(name: 'Mobile pckgs', icon: Icons.mobile_screen_share),
    EasyPaisaCard(name: 'Send Money', icon: Icons.send_to_mobile_outlined),
    EasyPaisaCard(name: 'Bill Payment', icon: Icons.payment),
    EasyPaisaCard(name: 'Mobile pckgs', icon: Icons.mobile_screen_share),
  ];

  List<EasyPaisaCard> gridView1 = [
    EasyPaisaCard(name: 'Easyload', icon: Icons.mobile_friendly_outlined),
    EasyPaisaCard(name: 'Easycash\n   Load', icon: Icons.handshake_outlined),
    EasyPaisaCard(name: 'Tohfa', icon: Icons.gif_box_outlined),
    EasyPaisaCard(name: 'Invite & Earn', icon: Icons.person_add_outlined),
    EasyPaisaCard(name: 'RaastPay', icon: Icons.home_work_outlined),
    EasyPaisaCard(name: 'Mini App', icon: Icons.app_registration_outlined),
    EasyPaisaCard(name: 'Savings', icon: Icons.money_off_sharp),
    EasyPaisaCard(name: 'Buy Now Pay Later', icon: Icons.paypal_outlined),
    EasyPaisaCard(name: 'Insurance', icon: Icons.image_not_supported_outlined),
    EasyPaisaCard(name: 'Donations', icon: Icons.payment_sharp),
    EasyPaisaCard(name: 'Rs1 Game', icon: Icons.circle_outlined),
    EasyPaisaCard(name: 'See All', icon: Icons.sms_outlined),
  ];
  List<EasyPaisaCard> gridView2 = [
    EasyPaisaCard(name: 'Invite & Earn', icon: Icons.person_add_outlined),
    EasyPaisaCard(name: 'RaastPay', icon: Icons.home_work_outlined),
    EasyPaisaCard(name: 'Mini App', icon: Icons.app_registration_outlined),
    EasyPaisaCard(name: 'Savings', icon: Icons.money_off_sharp),
    EasyPaisaCard(name: 'Buy Now Pay Later', icon: Icons.paypal_outlined),
    EasyPaisaCard(name: 'Insurance', icon: Icons.image_not_supported_outlined),
    EasyPaisaCard(name: 'Donations', icon: Icons.payment_sharp),
    EasyPaisaCard(name: 'Rs1 Game', icon: Icons.circle_outlined),
    EasyPaisaCard(name: 'See All', icon: Icons.sms_outlined),
  ];

  List<DebitCards> debitCard = [
    DebitCards(
        name: 'Online Card',
        text: 'Only for Online \n Payment in Pakistan',
        color: CHIStyles.darkSuccessColor,
        toRoute: const Test1()),
    DebitCards(
        name: 'Plastic Card',
        text: 'Use at any ATM or Shop\n in Pakistan',
        color: CHIStyles.checkboxTextColor,
        toRoute: const Test2()),
  ];
}
