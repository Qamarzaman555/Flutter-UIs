import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'bedroom_vm.dart';

class BedRoomVU extends StackedView<BedRoomVM> {
  const BedRoomVU({super.key});

  @override
  Widget builder(BuildContext context, BedRoomVM viewModel, Widget? child) =>
      Scaffold(
        appBar: AppBar(
          title: Text('BedRoom'),
        ),
      );

  @override
  BedRoomVM viewModelBuilder(BuildContext context) => BedRoomVM();
}
