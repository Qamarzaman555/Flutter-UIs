// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'home_vm.dart';
import 'qamar_table.dart';

class HomeVU extends StackedView<HomeVM> {
  const HomeVU({super.key});

  @override
  Widget builder(BuildContext context, HomeVM viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TEST'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Change View'),
                value: viewModel.isList,
                onChanged: (v) {
                  viewModel.onChangeView(v);
                },
              ),
              SwitchListTile(
                title: const Text('Change Delete Option'),
                value: viewModel.isDelete,
                onChanged: (v) {
                  viewModel.onShowDeleteOpt();
                },
              ),
              QamarTable(
                isList: viewModel.isList,
                persons: viewModel.persons,
                isDelete: viewModel.isDelete,
                onPress: (p) {
                  viewModel.onDeletePerson(p);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeVM viewModelBuilder(BuildContext context) {
    return HomeVM();
  }
}
