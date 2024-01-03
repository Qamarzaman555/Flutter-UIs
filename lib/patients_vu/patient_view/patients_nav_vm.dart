import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../patient_model/patient_model.dart';
import 'patient_models./patient_models.dart';

class PatientsNavVM extends BaseViewModel {
  PatientsNavVM() {
    getRepeatList(dataSet);
  }

  //actually methid call ni hwa
  List<PatientModel> searchedPatients = [];

  List<PatientModel> patientsList = [
    PatientModel(
        patientName: 'M. Bilal Liaquat',
        regNo: 'CHI-NH-0012',
        gender: 'Male',
        age: 28),
    PatientModel(
        patientName: 'Shah Zaman',
        regNo: 'CHI-NH-0013',
        gender: 'Male',
        age: 30),
    PatientModel(
        patientName: 'Hassan Syed',
        regNo: 'CHI-NH-0014',
        gender: 'Male',
        age: 32),
    PatientModel(
      patientName: 'Hassan Zaman',
      regNo: 'CHI-NH-0016',
      gender: 'Male',
      age: 28,
    )
  ];

  onDeletePatient(int index) {
    patientsList.removeAt(index);
    notifyListeners();
  }

  onAddPatient(value) {
    patientsList.add(value);
    notifyListeners();
  }

  onUpdatePatient(value, index) {
    patientsList[index] = value;
    notifyListeners();
  }

  void onSearchPatient(value) {
    if (value != null || value.isNotEmpty) {
      searchedPatients = patientsList
          .where((element) =>
              element.patientName!.toLowerCase().contains(value.toString()))
          .toList();
    } else {
      searchedPatients.clear();
    }
    notifyListeners();
  }

  //yes

  // List<Data> dataSet = [
  //   Data(name: 'Qamar'),
  //   Data(name: 'Ali'),
  //   Data(name: 'Abbas'),
  // ];
  // List<Widget> repeatList = [];
  // List<Widget>? getRepeatList(List<Data> dataSet) {
  //   Widget data;
  //   for (int i = 0; i < dataSet.length; i++) {
  //     data = Text('${dataSet[i].name}');
  //     repeatList.add(data);
  //   }
  //   debugPrint('${repeatList.first}');
  //   return repeatList;
  // }

  List<Data> dataSet = [
    Data(name: 'Qamar'),
    Data(name: 'Ali'),
    Data(name: 'Abbas'),
  ];

  List<Widget> repeatList = [];
  List<Widget>? getRepeatList(List<Data> dataSet) {
    for (int i = 0; i < dataSet.length; i++) {
      repeatList.add(Text('${dataSet[i].name}'));
    }
    debugPrint('${repeatList.first}');
    return repeatList;
  }
}
