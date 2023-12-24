import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../patient_form/patient_form_vu.dart';
import 'patients_nav_vm.dart';

class PatientsNavVU extends StackedView<PatientsNavVM> {
  const PatientsNavVU({super.key});

  @override
  Widget builder(BuildContext context, PatientsNavVM viewModel, Widget? child) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          children: [
            TextFormField(
              onChanged: viewModel.onSearchPatient,
              decoration: InputDecoration(
                hintText: 'Search Patient',
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: const Icon(Icons.search, color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                  itemCount: viewModel.searchedPatients.isEmpty
                      ? viewModel.patientsList.length
                      : viewModel.searchedPatients.length,
                  itemBuilder: (context, index) {
                    final patient = viewModel.searchedPatients.isEmpty
                        ? viewModel.patientsList[index]
                        : viewModel.searchedPatients[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(12),
                        width: MediaQuery.sizeOf(context).width,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${patient.patientName}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    '${patient.regNo}',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                  IntrinsicHeight(
                                      child: Row(
                                    children: [
                                      Text(
                                        '${patient.gender}',
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                      const VerticalDivider(
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        '${patient.age}',
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return PatientFormVU(
                                      patient: viewModel.patientsList[index],
                                    );
                                  })).then((value) {
                                    if (value != null) {
                                      viewModel.onUpdatePatient(value, index);
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                )),
                            IconButton(
                                onPressed: () {
                                  viewModel.onDeletePatient(index);
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PatientFormVU();
          })).then((value) {
            if (value != null) {
              viewModel.onAddPatient(value);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  PatientsNavVM viewModelBuilder(BuildContext context) => PatientsNavVM();
}
