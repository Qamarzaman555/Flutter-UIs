// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

import 'package:stacked/stacked.dart';

import '../chat_details/chat_detail_form/form_vu.dart';
import 'add_chat_vm.dart';

class AddChatVU extends StackedView<AddChatVM> {
  const AddChatVU({super.key});

  @override
  Widget builder(BuildContext context, AddChatVM viewModel, Widget? child) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            rowCell(Icons.group, 'New Group'),
            InkWell(
                onTap: () {
                  CHIRouter.push(context, ChatDetailFormVu());
                },
                child: rowCell(Icons.person_add, 'New contact',
                    icon2: Icons.qr_code)),
            rowCell(Icons.groups, 'New community'),
            _footTextWidget('Contacts on WhatsApp'),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    child: rowCell(Icons.groups, 'New community'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar customAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: CHIStyles.darkSuccessColor,
      leading: iconBtn(Icons.arrow_back, () {
        Navigator.pop(context);
      }),
      title: _appBaritle('Search contact'),
      actions: [
        iconBtn(Icons.search_outlined, () {}),
        iconBtn(Icons.more_vert, () {})
      ],
    );
  }

  Widget iconBtn(IconData icon, void Function()? onpressed) {
    return IconButton(
        onPressed: onpressed,
        icon: Icon(
          icon,
          color: CHIStyles.whiteColor,
        ));
  }

  Widget rowCell(IconData icon1, String text, {IconData? icon2}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: CHIStyles.darkSuccessColor,
            child: Icon(
              icon1,
              color: CHIStyles.whiteColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              text,
              style: CHIStyles.mdBoldStyle,
            ),
          ),
          const Spacer(),
          Icon(
            icon2,
            color: Colors.grey.shade500,
          ),
        ],
      ),
    );
  }

  Widget _appBaritle(String text) {
    return Text(
      text,
      style: CHIStyles.mdNormalStyle.copyWith(color: CHIStyles.whiteColor),
    );
  }

  Widget _footTextWidget(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        text,
        style: TextStyle(
            overflow: TextOverflow.ellipsis, color: Colors.grey.shade500),
      ),
    );
  }

  @override
  AddChatVM viewModelBuilder(BuildContext context) {
    return AddChatVM();
  }
}
