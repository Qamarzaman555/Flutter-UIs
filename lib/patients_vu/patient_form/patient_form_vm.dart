import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../patient_model/patient_model.dart';

class PatientFormVM extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  PatientModel patient = PatientModel();

  // String? name;
  // String? regNo;
  // String? gender;
  // int? age;

  String? onPatientNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Patient name is required';
    }
    return null;
  }

  String? onRegNoValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'registeration no is required';
    }
    return null;
  }

  String? onGenderValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Gender is required';
    }
    return null;
  }

  String? onAgeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    return null;
  }

  onPatientNameSaved(value) {
    patient.patientName = value!;
  }

  onRegNoSaved(String? value) {
    patient.regNo = value!;
  }

  onGenderSaved(String? value) {
    patient.gender = value!;
  }

  onAgeSaved(String? value) {
    patient.age = int.parse(value!);
  }

  onSavedPatient(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Navigator.pop(context, patient);
    }
  }
}
