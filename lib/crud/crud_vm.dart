import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'crud_model.dart';

class CrudVM extends BaseViewModel {
  List<CrudData> crudData = [
    CrudData(name: "Qamar"),
    CrudData(name: "Sayad"),
    CrudData(name: "Afridi"),
    CrudData(name: "Ali"),
    CrudData(name: "Mekan"),
    CrudData(name: "Khan"),
  ];

  final formKey = GlobalKey<FormState>();

  String? name;

  onSaveName(String? value) {
    name = value;
  }

  String? onValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is required';
    }
    return null;
  }

  onSubmit(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final newName = CrudData(
        name: name,
      );

      Navigator.pop(context, newName);
      debugPrint('${newName.name}');
    }
  }

  onRemoveName(int index) {
    crudData.removeAt(index);
    notifyListeners();
  }

  onUpdateName(index, value) {
    crudData[index] = value;
    notifyListeners();
  }

  onAddName(value) {
    crudData.add(value);
    notifyListeners();
  }
}
