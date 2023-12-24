import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'ep_acc_landscape_vu.dart';
import 'ep_acc_potrait_vu.dart';
import 'ep_account_vm.dart';

class AccountSettingView extends StackedView<AccountSettingViewModel> {
  const AccountSettingView({super.key});

  @override
  Widget builder(
      BuildContext context, AccountSettingViewModel viewModel, Widget? child) {
    Orientation orientations = MediaQuery.of(context).orientation;

    return Scaffold(
      body: orientations == Orientation.portrait
          ? AccSettingPotraitVU(viewModel)
          : AccSettingLandscapeVU(viewModel),
    );
  }

  @override
  AccountSettingViewModel viewModelBuilder(BuildContext context) {
    return AccountSettingViewModel();
  }
}
