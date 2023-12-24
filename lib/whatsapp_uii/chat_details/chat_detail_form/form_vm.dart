import 'package:flutter/material.dart';
import 'package:practice/whatsapp_uii/whatsapp_model/whatsapp_model.dart';
import 'package:stacked/stacked.dart';

class ChatDetailFormVM extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  WhatsappModel? chat;

  String? name;
  String? message;
  int? number;

  void onSaveChat(context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      chat = WhatsappModel(
        name: name!,
        message: message!,
        number: number!,
      );
      Navigator.pop(context, chat);
      Navigator.pop(context, chat);
    }
  }

  onNameSaved(String? value) {
    name = value!;
  }

  onMessageSaved(String? value) {
    message = value!;
  }

  onNumberSaved(String? value) {
    number = int.parse(value!);
  }

  String? nameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? messageValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Message is required';
    }
    return null;
  }

  String? numberValidator(value) {
    if (value == null || value.toString().isEmpty) {
      return 'Phone Number is required';
    }
    return null;
  }
}
