import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import '../Models/easypaisa_model.dart';
import '../test_folders/tele_bank_vu.dart';

class AccountSettingViewModel extends BaseViewModel {
  List<AccountDetails> accounts = [
    AccountDetails(
        icon1: Icons.person_outline_outlined,
        text: 'Account Information',
        icon2: Icons.arrow_forward_ios_outlined),
    AccountDetails(
        icon1: Icons.password_outlined,
        text: 'Change EasyPaisa Account Pin',
        icon2: Icons.arrow_forward_ios_outlined),
    AccountDetails(
        toRoute: const LinkTeleBankView(),
        icon1: Icons.card_membership_outlined,
        text: 'Link Telenor Microfinance Bank',
        icon2: Icons.arrow_forward_ios_outlined),
    AccountDetails(
        icon1: Icons.add_card_outlined,
        text: 'Link Debit Card',
        icon2: Icons.arrow_forward_ios_outlined),
    AccountDetails(
        icon1: Icons.card_membership_outlined,
        text: 'Get Your Tax Certificate',
        icon2: Icons.arrow_forward_ios_outlined),
    AccountDetails(
        icon1: Icons.person_2_rounded,
        text: 'Open New Gen Account',
        icon2: Icons.arrow_forward_ios_outlined),
    AccountDetails(
        icon1: Icons.qr_code_2_outlined,
        text: 'Become An Easypaisa Merchant',
        icon2: Icons.arrow_forward_ios_outlined),
  ];
}
