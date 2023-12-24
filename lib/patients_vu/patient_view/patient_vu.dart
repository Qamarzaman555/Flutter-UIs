import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'patient_vm.dart';

class PatientVU extends StackedView<PatientVM> {
  const PatientVU({super.key});

  @override
  Widget builder(BuildContext context, PatientVM viewModel, Widget? child) =>
      Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text('Patients'),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.grey.shade100,
              child: const Icon(Icons.menu),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.ondemand_video_outlined,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
        body: Center(
          child: viewModel.widgetOptions.elementAt(viewModel.selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Observations',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Patients',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call_outlined),
              label: 'Call',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail_outline),
              label: 'Chat',
            ),
          ],
          currentIndex: viewModel.selectedIndex,
          selectedItemColor: Colors.blue.shade900,
          onTap: viewModel.onItemTapped,
          unselectedIconTheme: const IconThemeData(color: Colors.black),
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
        ),
      );

  @override
  PatientVM viewModelBuilder(BuildContext context) => PatientVM();
}
