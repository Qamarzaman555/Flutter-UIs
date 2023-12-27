import 'package:flutter/material.dart';
import 'package:practice/animation/button_animation/button_animation_vu/button_animation_vm.dart';
import 'package:practice/ui_kit/local_pub.dart';
import 'package:stacked/stacked.dart';

class ButtonAnimationVU extends StackedView<ButtonAnimationVM> {
  const ButtonAnimationVU({super.key});

  @override
  Widget builder(
      BuildContext context, ButtonAnimationVM viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: Title(color: Colors.black, child: const Text("Animations")),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(32),
            child: AnimatedContainer(
              duration: const Duration(seconds: 2),
              curve: Curves.easeIn,
              width: viewModel.state == ButtonState.init
                  ? MediaQuery.of(context).size.width
                  : 70,
              onEnd: () {
                viewModel.toggleAnimation();
              },
              height: 70,
              child:
                  viewModel.isAnimating || viewModel.state == ButtonState.init
                      ? payNowBtn(viewModel, context)
                      : buildSmallBtn(viewModel),
            ),
          ),
          20.spaceY,
          AnimatedOpacity(
            opacity: viewModel.opacityLevel,
            duration: const Duration(seconds: 3),
            child: const Icon(
              Icons.done,
              size: 32,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }

  Widget payNowBtn(ButtonAnimationVM viewModel, BuildContext context) =>
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 24, color: Colors.white),
          shape: const StadiumBorder(),
        ),
        onPressed:
            //  null
            viewModel.isPressed != true
                ? () async {
                    viewModel.loadingState();
                    await Future.delayed(const Duration(seconds: 3));
                    viewModel.doneState();
                    await Future.delayed(const Duration(milliseconds: 500));
                    viewModel.setOpacity();
                    await Future.delayed(const Duration(seconds: 3));
                    viewModel.initState();
                    viewModel.resetOpacity();
                  }
                : () {},
        child: const FittedBox(child: Text("Pay Now")),
      );

  Widget buildSmallBtn(ButtonAnimationVM viewModel) {
    return Container(
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      child: Center(
        child: viewModel.state == ButtonState.done
            ? AnimatedOpacity(
                opacity: viewModel.opacityLevel,
                duration: const Duration(milliseconds: 500),
                child: const Icon(
                  Icons.done,
                  size: 44,
                  color: Colors.white,
                ),
              )
            // const IconAnimation()
            : const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  @override
  ButtonAnimationVM viewModelBuilder(BuildContext context) {
    return ButtonAnimationVM();
  }
}

enum ButtonState { init, loading, done }



// class AnimationLoader1 extends StatefulWidget {
//   @override
//   _AnimationLoaderState createState() => _AnimationLoaderState();
// }

// class _AnimationLoaderState extends State<AnimationLoader1> {
//   bool isAnimating = true;
//   ButtonState state = ButtonState.init;

//   @override
//   Widget build(BuildContext context) {
//     final isDone = state == ButtonState.done;
//     final isStretched = isAnimating || state == ButtonState.init;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: Title(color: Colors.black, child: Text("Animations")),
//         centerTitle: true,
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         padding: EdgeInsets.all(32),
//         child: AnimatedContainer(
//           duration: Duration(milliseconds: 2000),
//           // curve: Curves.easeIn,
//           width: state == ButtonState.init ? width : 70,
//           onEnd: () => setState(() {
//             isAnimating = !isAnimating;
//           }),
//           height: 70,
//           child: isStretched ? payNowBtn() : buildSmallBtn(isDone),
//         ),
//       ),
//     );
//   }

//   Widget payNowBtn() => OutlinedButton(
//         style: OutlinedButton.styleFrom(
//             textStyle: TextStyle(fontSize: 24, color: Colors.white),
//             minimumSize: Size.fromHeight(72),
//             shape: StadiumBorder()),
//         child: FittedBox(child: Text("Pay Now")),
//         onPressed: () async {
//           setState(() {
//             state = ButtonState.loading;
//           });
//           await Future.delayed(Duration(seconds: 3));
//           setState(() {
//             state = ButtonState.done;
//           });
//           await Future.delayed(Duration(seconds: 3));
//           setState(
//             () {
//               state = ButtonState.init;
//             },
//           );
//           await Future.delayed(Duration(seconds: 3));
//         },
//       );

//   Widget buildSmallBtn(bool isDone) {
//     final color = isDone ? Colors.green : Colors.indigo;

//     return Container(
//       decoration: BoxDecoration(shape: BoxShape.circle, color: color),
//       child: Center(
//         child: isDone
//             ? Icon(
//                 Icons.done,
//                 size: 52,
//                 color: Colors.white,
//               )
//             : CircularProgressIndicator(color: Colors.white),
//       ),
//     );
//   }
// }
