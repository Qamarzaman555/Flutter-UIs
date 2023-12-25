import 'package:flutter/material.dart';
import 'package:practice/animation_integration/bedroom_view/bedroom_vm.dart';
import 'package:stacked/stacked.dart';
import 'package:typethis/typethis.dart';

class BedRoomVU extends StackedView<BedRoomVM> {
  const BedRoomVU({super.key});

  @override
  Widget builder(BuildContext context, BedRoomVM viewModel, Widget? child) =>
      Scaffold(
          backgroundColor: const Color.fromRGBO(248, 248, 250, 30),
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(161, 157, 199, 220),
            title: const Text('Bed Room'),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromRGBO(210, 208, 227, 100),
                  Color.fromRGBO(161, 157, 199, 100),
                  Color.fromRGBO(152, 145, 192, 100),
                ],
                tileMode: TileMode.mirror,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: TypeThis(
                    string: 'contents will be available soon',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                    speed: 50,
                  ),
                ),
              ],
            ),
          ));

  @override
  BedRoomVM viewModelBuilder(BuildContext context) => BedRoomVM();
}
