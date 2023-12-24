// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

import 'package:practice/whatsapp_uii/whatsapp_model/whatsapp_model.dart';

import 'chat_detail_form/form_vu.dart';

class ChatDetailVU extends StatelessWidget {
  ChatDetailVU({required this.chat, super.key});
  WhatsappModel chat;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: customAppBar(context),
            body: StatefulBuilder(builder: (context, setState) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _headTextWidget(chat.name),
                    _headTextWidget(chat.number.toString()),
                    _headTextWidget(chat.message),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: CHIButton(
                          backgroundColor: CHIStyles.darkSuccessColor,
                          onTap: () {
                            CHIRouter.push(
                                    context, ChatDetailFormVu(chat: chat))
                                .then((value) {
                              if (value != null) {
                                chat = value;
                                setState(() {});
                              }
                            });
                          },
                          lable: 'Edit'),
                    )
                  ]);
            })));
  }

  AppBar customAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: CHIStyles.darkSuccessColor,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: CHIStyles.whiteColor,
          )),
      title: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundImage: const AssetImage('assets/icons/google_logo.png'),
            backgroundColor: CHIStyles.darkSuccessColor,
          ),
          12.spaceX,
          _appBaritle(chat.name)
        ],
      ),
      actions: [
        appBarIconBtn(() {}, Icons.videocam),
        appBarIconBtn(() {}, Icons.phone),
        appBarIconBtn(() {}, Icons.more_vert)
      ],
    );
  }

  Widget _appBaritle(String text) {
    return Text(
      text,
      style: CHIStyles.mdNormalStyle.copyWith(color: CHIStyles.whiteColor),
    );
  }

  Widget _headTextWidget(String text) {
    return Text(
      text,
      style: CHIStyles.mdBoldStyle,
    );
  }

  Widget appBarIconBtn(Function()? onPressed, IconData icon) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: CHIStyles.whiteColor,
      ),
    );
  }
}
