import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

import 'package:stacked/stacked.dart';

import 'updates_vm.dart';

class UpdatesVU extends StackedView<UpdatesVM> {
  const UpdatesVU({super.key});

  @override
  Widget builder(BuildContext context, UpdatesVM viewModel, Widget? child) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.spaceY,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _headTextWidget('Status'),
                Icon(
                  Icons.more_vert,
                  color: Colors.grey.shade500,
                )
              ],
            ),
            12.spaceY,
            myStatus(),
            12.spaceY,
            _headTextWidget('Recent Updates'),
            12.spaceY,
            myStatusInRecents(),
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.statusList.length,
                itemBuilder: (context, index) {
                  return chatsStatus(viewModel, index);
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: floatingBtn(),
    );
  }

  Widget myStatus() {
    return Row(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            circleImage(),
            Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                size: 20,
              ),
            )
          ],
        ),
        12.spaceX,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headTextWidget('My Status'),
            _footTextWidget('Tap to add status update')
          ],
        ),
      ],
    );
  }

  Widget myStatusInRecents() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('assets/icons/google_logo.png'),
        ),
        12.spaceX,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headTextWidget('My Status'),
            _footTextWidget('Tap to add status update')
          ],
        ),
      ],
    );
  }

  Widget chatsStatus(UpdatesVM viewModel, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          circleImage(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  viewModel.statusList[index].name,
                  style: CHIStyles.mdBoldStyle,
                ),
                Text(
                  viewModel.statusList[index].time,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget floatingBtn() {
    return FloatingActionButton(
      backgroundColor: CHIStyles.darkSuccessColor,
      onPressed: () {},
      child: Icon(
        Icons.camera_alt,
        color: CHIStyles.whiteColor,
      ),
    );
  }

  Widget circleImage() {
    return const CircleAvatar(
      backgroundColor: Colors.white,
      backgroundImage: AssetImage('assets/icons/google_logo.png'),
    );
  }

  Widget _footTextWidget(String text) {
    return Text(
      text,
      style: TextStyle(
          overflow: TextOverflow.ellipsis, color: Colors.grey.shade500),
    );
  }

  Widget _headTextWidget(String text) {
    return Text(
      text,
      style: CHIStyles.mdBoldStyle,
    );
  }

  @override
  UpdatesVM viewModelBuilder(BuildContext context) {
    return UpdatesVM();
  }
}
