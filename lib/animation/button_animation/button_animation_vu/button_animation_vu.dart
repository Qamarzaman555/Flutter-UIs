import 'package:flutter/material.dart';
import 'package:practice/animation/button_animation/button_animation_vu/button_animation_vm.dart';
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
      body: Container(
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
          child: viewModel.isAnimating || viewModel.state == ButtonState.init
              ? payNowBtn(viewModel, context)
              : buildSmallBtn(viewModel),
        ),
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
