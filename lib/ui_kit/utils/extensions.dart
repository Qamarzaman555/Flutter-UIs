part of '../local_pub.dart';

extension SpaceXY on num {
  SizedBox get spaceX => SizedBox(width: toDouble());
  SizedBox get spaceY => SizedBox(height: toDouble());
}

extension BMPadding on num {
  EdgeInsets get padAll => EdgeInsets.all(toDouble());
  EdgeInsets get padX => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get padY => EdgeInsets.symmetric(vertical: toDouble());
}

extension CreatedAt on Object {
  DateTime get createdAt => DateTime.now();
}

extension Timestamp on DateTime {
  int get timeStamp => millisecondsSinceEpoch ~/ 1000;
}

extension StartOfDay on DateTime {
  DateTime get startOfDay => DateTime(year, month, day);
}

extension EndOfDay on DateTime {
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);
}

extension DateObject on int {
  DateTime get date => DateTime.fromMillisecondsSinceEpoch(
      toString().length <= 10 ? this * 1000 : this);
}

extension FormattedDateTime on DateTime {
  String format(String format) {
    return DateFormat(format).format(this);
  }
}

extension StringChecker on String? {
  bool get existAndNotEmpty => this?.isNotEmpty ?? false;
}

extension ScreenSize on BuildContext {
  Size get kSize => MediaQuery.of(this).size;
  double get kWidth => kSize.width;
  double get kHeight => kSize.height;
  Orientation get kOrientation => MediaQuery.of(this).orientation;
  double get kDevicePixelRatio => MediaQuery.of(this).devicePixelRatio;
  EdgeInsets get kViewInsets => MediaQuery.of(this).viewInsets;
  double get kShortestSide => kSize.shortestSide;
  bool get isMobile => !kIsWeb && kShortestSide < 550;
  bool get isWebSmall => !isMobile && kWidth < 800;
  bool get isMedium => kWidth <= 1100;
  bool get isLarge => kWidth > 1100;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  ThemeData get appTheme => Theme.of(this);
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
