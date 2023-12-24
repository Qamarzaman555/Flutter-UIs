import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';
import 'package:stacked/stacked.dart';

import 'groups_vm.dart';

class GroupsVU extends StackedView<GroupsVM> {
  const GroupsVU({super.key});

  @override
  Widget builder(BuildContext context, GroupsVM viewModel, Widget? child) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('assets/brands/Whatsapp_Logo.png')),
            40.spaceY,
            _headTextWidget('Stay connected with a community'),
            12.spaceY,
            _footTextWidget(
              'Communities bring members together in topic-based groups, and make it easy to get admin announcements. Any community you are added to wil appear here.',
              Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _footTextWidget(
                      'See example communities', CHIStyles.darkSuccessColor),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: CHIStyles.darkSuccessColor,
                    size: 16,
                  )
                ],
              ),
            ),
            20.spaceY,
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: CHIStyles.darkSuccessColor),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text('Start your community'),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _footTextWidget(String text, Color color) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: color),
    );
  }

  Widget _headTextWidget(String text) {
    return Text(
      text,
      style: CHIStyles.mdBoldStyle,
    );
  }

  @override
  GroupsVM viewModelBuilder(BuildContext context) {
    return GroupsVM();
  }
}
