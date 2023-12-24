import 'package:stacked/stacked.dart';

import '../patient_model/patient_model.dart';

class PatientsNavVM extends BaseViewModel {
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
}
