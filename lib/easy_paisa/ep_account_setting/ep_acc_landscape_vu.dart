import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

import 'ep_account_vm.dart';

class AccSettingLandscapeVU extends StatelessWidget {
  const AccSettingLandscapeVU(this.viewModel, {super.key});
  final AccountSettingViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                        )),
                  ],
                ),
                Text(
                  'Account Setting',
                  style: CHIStyles.displayXsBoldStyle,
                ),
                4.spaceY,
                Text(
                  'Account info, Settings & More',
                  style: CHIStyles.mdMediumStyle,
                ),
                20.spaceY,
                Text(
                  'ACCOUNT',
                  style: CHIStyles.mdNormalStyle,
                ),
                20.spaceY,
                _gridViewOptions(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _gridViewOptions(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.accounts.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: viewModel.accounts[index].toRoute != null
                ? () {
                    CHIRouter.push(context, viewModel.accounts[index].toRoute!);
                  }
                : () => debugPrint('Not Found'),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    viewModel.accounts[index].icon1,
                    color: Colors.green,
                  ),
                  8.spaceY,
                  Text(
                    viewModel.accounts[index].text,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
