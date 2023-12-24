import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

import 'ep_account_vm.dart';

class AccSettingPotraitVU extends StatelessWidget {
  const AccSettingPotraitVU(this.viewModel, {super.key});
  final AccountSettingViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                  )),
              12.spaceY,
              Text(
                'Account Setting',
                style: CHIStyles.displayXsBoldStyle,
              ),
              4.spaceY,
              Text(
                'Account info, Settings & More',
                style: CHIStyles.mdMediumStyle,
              ),
              40.spaceY,
              Text(
                'ACCOUNT',
                style: CHIStyles.mdNormalStyle,
              ),
              20.spaceY,
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.accounts.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: viewModel.accounts[index].toRoute != null
                          ? () {
                              CHIRouter.push(
                                  context, viewModel.accounts[index].toRoute!);
                            }
                          : () => debugPrint('Not Found'),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            Icon(
                              viewModel.accounts[index].icon1,
                              color: Colors.greenAccent,
                            ),
                            12.spaceX,
                            Expanded(
                              child: Text(
                                viewModel.accounts[index].text,
                                style: CHIStyles.mdBoldStyle,
                              ),
                            ),
                            Icon(
                              viewModel.accounts[index].icon2,
                              color: CHIStyles.greyColor,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
