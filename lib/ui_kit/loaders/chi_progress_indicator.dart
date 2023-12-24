part of '../local_pub.dart';

class CHIProgressIndicator extends StatelessWidget {
  const CHIProgressIndicator(this.isBusy,
      {super.key, this.color, this.loaderType = LoaderType.linear});
  final LoaderType loaderType;
  final bool isBusy;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isBusy,
      child: loaderType == LoaderType.linear
          ? LinearProgressIndicator(
              color: color ??
                  Theme.of(context).extension<CHITheme>()?.primaryColor)
          : Center(
              child: CircularProgressIndicator(
                color: color ??
                    Theme.of(context).extension<CHITheme>()?.primaryColor,
              ),
            ),
    );
  }
}

enum LoaderType { linear, circular }
