import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:practice/animation/chi_animated_list_view/chi_animated_list_view.dart';
import 'package:practice/animation/list_view_animation/list_view_animation_vu/list_view_animation_vm.dart';
import 'package:stacked/stacked.dart';

class ListViewAnimationVU extends StackedView<ListViewAnimationVM> {
  const ListViewAnimationVU({super.key});

  @override
  Widget builder(
          BuildContext context, ListViewAnimationVM viewModel, Widget? child) =>
      Scaffold(
        backgroundColor: const Color.fromRGBO(248, 248, 250, 30),
        appBar: AppBar(
          title: const Text("List View Animation"),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(248, 248, 250, 30),

          // systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: CHIAnimatedListView(
            itemCount: viewModel.listModel.length,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('${viewModel.listModel[index].name}'),
                // Text('${viewModel.listModel[index].regNo}'),
                // Text('${viewModel.listModel[index].age}'),
              ],
            )),
        // AnimationLimiter(
        //   child: ListView.builder(
        //     padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
        //     physics: const BouncingScrollPhysics(
        //         parent: AlwaysScrollableScrollPhysics()),
        //     itemCount: viewModel.listModel.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return AnimationConfiguration.staggeredList(
        //         position: index,
        //         delay: const Duration(milliseconds: 100),
        //         child: SlideAnimation(
        //           duration: const Duration(milliseconds: 2500),
        //           curve: Curves.fastLinearToSlowEaseIn,
        //           child: FadeInAnimation(
        //             curve: Curves.fastLinearToSlowEaseIn,
        //             duration: const Duration(milliseconds: 2500),
        //             child: Container(
        //                 margin: EdgeInsets.only(
        //                     bottom: MediaQuery.of(context).size.width / 32),
        //                 padding: const EdgeInsets.all(12),
        //                 decoration: BoxDecoration(
        //                   color: Colors.grey.shade300,
        //                   borderRadius:
        //                       const BorderRadius.all(Radius.circular(20)),
        //                   boxShadow: [
        //                     BoxShadow(
        //                       color: Colors.black.withOpacity(0.1),
        //                       blurRadius: 40,
        //                       spreadRadius: 10,
        //                     ),
        //                   ],
        //                 ),
        //                 child:
        // Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text('${viewModel.listModel[index].name}'),
        //                     Text('${viewModel.listModel[index].regNo}'),
        //                     Text('${viewModel.listModel[index].age}'),
        //                   ],
        //                 )),
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // ),
      );

  @override
  ListViewAnimationVM viewModelBuilder(BuildContext context) =>
      ListViewAnimationVM();
}
