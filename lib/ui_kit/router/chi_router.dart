part of '../local_pub.dart';

class CHIRouter {
  static Future push(BuildContext context, Widget nextPage) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextPage),
    );
  }

  static Future pushReplacement(BuildContext context, Widget nextPage) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextPage),
    );
  }

  static popUntilHomeRoute(BuildContext context, Widget nextPage) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => nextPage),
      (route) => false,
    );
  }

  static pushAndPopUntilHomeRoute(BuildContext context, String nextPage,
      {Object? arguments}) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        nextPage, (route) => route.isFirst,
        arguments: arguments);
  }

  static Future<void> exitApp({bool? animated}) async {
    await SystemChannels.platform
        .invokeMethod<void>('SystemNavigator.pop', animated);
  }
}
