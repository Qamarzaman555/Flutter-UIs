// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';
import 'package:practice/whatsapp_uii/whatsapp_model/whatsapp_model.dart';

import 'package:stacked/stacked.dart';

import 'form_vm.dart';

class ChatDetailFormVu extends StackedView<ChatDetailFormVM> {
  ChatDetailFormVu({this.chat, super.key});
  WhatsappModel? chat;

  @override
  Widget builder(
      BuildContext context, ChatDetailFormVM viewModel, Widget? child) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: viewModel.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              nameTextField(viewModel),
              12.spaceY,
              numberTextField(viewModel),
              12.spaceY,
              messageTextField(viewModel),
              12.spaceY,
              CHIButton(
                onTap: () {
                  viewModel.onSaveChat(context);
                },
                backgroundColor: CHIStyles.darkSuccessColor,
                lable: 'Save',
              )
            ],
          ),
        ),
      ),
    );
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
      title: _appBaritle('Edit Details'),
    );
  }

  Widget messageTextField(ChatDetailFormVM viewModel) {
    return CHITextField(
      hintText: 'Your Messsage',
      validator: viewModel.messageValidator,
      onSaved: viewModel.onMessageSaved,
      initialValue: chat?.message,
      fillColor: Colors.grey.shade200,
      borderRadius: 50,
    );
  }

  Widget numberTextField(ChatDetailFormVM viewModel) {
    return CHITextField(
      hintText: 'Phone Number',
      validator: viewModel.numberValidator,
      onSaved: viewModel.onNumberSaved,
      initialValue: chat?.number.toString(),
      fillColor: Colors.grey.shade200,
      borderRadius: 50,
    );
  }

  Widget nameTextField(ChatDetailFormVM viewModel) {
    return CHITextField(
      hintText: 'Name',
      initialValue: chat?.name,
      validator: viewModel.nameValidator,
      onSaved: viewModel.onNameSaved,
      fillColor: Colors.grey.shade200,
      borderRadius: 50,
    );
  }

  Widget _appBaritle(String text) {
    return Text(
      text,
      style: CHIStyles.mdNormalStyle.copyWith(color: CHIStyles.whiteColor),
    );
  }

  @override
  ChatDetailFormVM viewModelBuilder(BuildContext context) {
    return ChatDetailFormVM();
  }
}
