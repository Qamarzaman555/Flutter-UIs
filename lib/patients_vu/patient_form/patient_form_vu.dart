import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import '../patient_model/patient_model.dart';
import 'patient_form_vm.dart';

// ignore: must_be_immutable
class PatientFormVU extends StackedView<PatientFormVM> {
  PatientFormVU({this.patient, super.key});
  PatientModel? patient;

  @override
  Widget builder(BuildContext context, PatientFormVM viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Form'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: viewModel.formKey,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                customTextField(
                    hintText: 'Patient Name',
                    validator: viewModel.onPatientNameValidator,
                    onSaved: viewModel.onPatientNameSaved,
                    initialValue: patient?.patientName),
                const SizedBox(height: 12),
                customTextField(
                  hintText: 'Registeration No',
                  validator: viewModel.onRegNoValidator,
                  onSaved: viewModel.onRegNoSaved,
                  initialValue: patient?.regNo,
                ),
                const SizedBox(height: 12),
                customTextField(
                  hintText: 'Gender',
                  validator: viewModel.onGenderValidator,
                  onSaved: viewModel.onGenderSaved,
                  initialValue: patient?.gender,
                ),
                const SizedBox(height: 12),
                customTextField(
                  hintText: 'Age',
                  validator: viewModel.onAgeValidator,
                  onSaved: viewModel.onAgeSaved,
                  initialValue: patient?.age.toString(),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                    onPressed: () {
                      viewModel.onSavedPatient(context);
                    },
                    child: const Text('Save'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField customTextField({
    String? hintText,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    String? initialValue,
  }) {
    return TextFormField(
      initialValue: initialValue,
      onSaved: onSaved,
      validator: validator,
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
      ),
    );
  }

  @override
  PatientFormVM viewModelBuilder(BuildContext context) {
    return PatientFormVM();
  }
}
