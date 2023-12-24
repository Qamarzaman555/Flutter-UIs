import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';
import 'package:stacked/stacked.dart';

import 'pathC_vm.dart';

class PathCVU extends StackedView<PathCVM> {
  const PathCVU({super.key});

  @override
  Widget builder(BuildContext context, PathCVM viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'PATH',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              28.spaceY,
              const Text(
                textAlign: TextAlign.center,
                'Full-stack Development is the best choice for you!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              8.spaceY,
              const Text(
                textAlign: TextAlign.center,
                'Yor can swirch paths at any time',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              24.spaceY,
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.deepPurple, width: 2.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white24,
                        height: MediaQuery.sizeOf(context).height / 5,
                        width: MediaQuery.sizeOf(context).width,
                        child: const Image(
                          image: AssetImage('assets/brands/mimo.png'),
                        ),
                      ),
                      const Text(
                        'Full-stack Development',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Become a full-stack developer: Learn HTML, CSS, Javascript, and React as well as NodeJS, Express,and SQL',
                      ),
                      12.spaceY,
                      const Text(
                        'TECHNOLOGIES',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: viewModel.textList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.white30,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    viewModel.textList[index].text,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              backgroundColor: Colors.deepPurple),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 14.0),
                            child: Text(
                              'CONTINUE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'SEE ALL OPTIONS',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  PathCVM viewModelBuilder(BuildContext context) {
    return PathCVM();
  }
}
