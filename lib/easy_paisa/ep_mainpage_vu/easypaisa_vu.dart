import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

import 'package:stacked/stacked.dart';
import 'easypaisa_landscape_vu.dart';
import 'easypaisa_portraite_vu.dart';
import 'easypaisa_vm.dart';

class EasyPaisaView extends StackedView<EasyPaisaViewModel> {
  const EasyPaisaView({super.key});

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: customAppBar(),
        body: orientation == Orientation.portrait
            ? EasyPaisaPortraiteView(viewModel)
            : EasyPaisaLandscapeView(viewModel),
      ),
    );
  }

  @override
  EasyPaisaViewModel viewModelBuilder(BuildContext context) {
    final vm = EasyPaisaViewModel();
    vm.onGetPageController();
    return vm;
  }

  AppBar customAppBar() {
    return AppBar(
      elevation: 2,
      centerTitle: true,
      backgroundColor: const Color.fromRGBO(49, 189, 94, 1),
      title: const Text(
        'easypaisa',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.blue,
              ),
              // padding: const EdgeInsets.all(2),
              child: const Center(child: Text('QZ')),
            ),
            // const Positioned(
            //   bottom: 4,
            //   right: 0,
            //   child: Icon(Icons.menu),
            // )
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                )),
            12.spaceX,
          ],
        )
      ],
    );
  }
}
