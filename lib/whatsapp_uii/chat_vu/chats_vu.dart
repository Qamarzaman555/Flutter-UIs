// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';
import 'package:practice/whatsapp_uii/chat_details/chat_detatil_vu.dart';
import 'package:practice/whatsapp_uii/whatsapp_model/whatsapp_model.dart';

import 'package:stacked/stacked.dart';

import '../add_chat_vu/add_chat_vu.dart';
import 'chats_vm.dart';

class ChatsVU extends StackedView<ChatsVM> {
  ChatsVU({this.chat, super.key});
  WhatsappModel? chat;

  @override
  Widget builder(BuildContext context, ChatsVM viewModel, Widget? child) {
    return Scaffold(
      body: ListView.builder(
        itemCount: viewModel.chats.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child:
                chatListView(viewModel.chats[index], context, viewModel, index),
          );
        },
      ),
      floatingActionButton: floatingBtn(context, viewModel),
    );
  }

  Widget floatingBtn(BuildContext context, ChatsVM viewModel) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: CHIStyles.darkSuccessColor,
      onPressed: () {
        CHIRouter.push(context, const AddChatVU()).then((value) {
          if (value != null) {
            viewModel.onAddChat(value);
          }
        });
      },
      child: Icon(
        Icons.message,
        color: CHIStyles.whiteColor,
      ),
    );
  }

  Widget chatListView(
      WhatsappModel chat, BuildContext context, ChatsVM viewModel, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (
          context,
        ) {
          return ChatDetailVU(
            chat: chat,
          );
        })).then((value) {
          if (value != null) {
            viewModel.onUpdateChat(index, value);
          }
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/icons/google_logo.png'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headTextWidget(
                  chat.name,
                ),
                _footTextWidget(chat.message),
              ],
            ),
          ),
          const Spacer(),
          _footTextWidget('Yesterday'),
        ],
      ),
    );
  }

  Widget _footTextWidget(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey.shade500,
      ),
    );
  }

  Widget _headTextWidget(String text) {
    return Text(
      text,
      style: CHIStyles.mdBoldStyle,
    );
  }

  @override
  ChatsVM viewModelBuilder(BuildContext context) {
    return ChatsVM();
  }
}
