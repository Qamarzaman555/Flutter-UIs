import 'package:flutter/material.dart';

import 'package:practice/ui_kit/local_pub.dart';
import 'package:stacked/stacked.dart';

import 'calls_vm.dart';

class CallSVU extends StackedView<CallsVM> {
  const CallSVU({super.key});

  @override
  Widget builder(BuildContext context, CallsVM viewModel, Widget? child) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          createLinkCell(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: _headTextWidget('Recents'),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: viewModel.callList.length,
                  itemBuilder: (context, index) {
                    return recentCallsList(viewModel, index);
                  }))
        ],
      ),
      floatingActionButton: floatingBtn(),
    );
  }

  Widget recentCallsList(CallsVM viewModel, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          circleImage(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headTextWidget(
                  viewModel.callList[index].name,
                ),
                _footTextWidget(
                  viewModel.callList[index].time,
                )
              ],
            ),
          ),
          const Spacer(),
          Icon(
            Icons.phone,
            color: CHIStyles.darkSuccessColor,
          ),
        ],
      ),
    );
  }

  Widget createLinkCell() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: CHIStyles.darkSuccessColor,
            child: Icon(
              Icons.link_outlined,
              color: CHIStyles.whiteColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headTextWidget('Create call link'),
                _footTextWidget('Shares a link for your WhatsApp call')
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
        Icons.add_ic_call,
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
  CallsVM viewModelBuilder(BuildContext context) {
    return CallsVM();
  }
}
