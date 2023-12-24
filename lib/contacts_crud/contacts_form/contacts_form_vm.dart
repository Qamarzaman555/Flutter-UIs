import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../con_model/con_model.dart';

class ContactsFromVM extends BaseViewModel {
  int? selectedIndex = 0;

  List<String> sims = ['Sim 1', 'Sim 2'];
  ContactsModel? contact;
  final formKey = GlobalKey<FormState>();

  String? firstName;
  String? lastName;
  int? phone;
  String sim = 'Sim 1';

  onSelectSim(BuildContext context, int i) {
    selectedIndex = i;
    sim = sims[i];
    notifyListeners();
    Navigator.pop(context);
  }

  onSaveContact(context, bool forUpdate) {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      contact = ContactsModel(
        firstName: firstName!,
        lastName: lastName!,
        phone: phone!,
        sim: sim,
      );
      if (forUpdate) {
        Navigator.pop(context, contact);
      }
      Navigator.pop(context, contact);
    }
  }

  onFirstNameSaved(String? value) {
    firstName = value!;
  }

  onLastNameSaved(String? value) {
    lastName = value!;
  }

  onPhoneSaved(String? value) {
    phone = int.parse(value!);
  }

  String? firstNameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'First Name is required';
    }
    return null;
  }

  String? lastNameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Last Name is required';
    }
    return null;
  }

  String? phoneValidator(value) {
    if (value == null || value.toString().isEmpty) {
      return 'Phone is required';
    }
    return null;
  }
}
