part of '../local_pub.dart';

/// Custom theme extension [CHITheme] for CHI UI Kit.
class CHITheme extends ThemeExtension<CHITheme> {
  /// Primary Color for app.
  final Color? primaryColor;

  /// Primary Light Color for app.
  final Color? primaryLightColor;

  /// Secondary Color for app.
  final Color? secondryColor;

  /// Secondary Light Color for app.
  final Color? secondryLightColor;

  /// Accent Color for app.
  final Color? accentColor;

  /// Selected Item Color for some specific cases.
  final Color? selectedItemColor;

  /// Card Color for app.
  final Color? cardColor;

  /// Action Button Color for app.
  final Color? actionButtonColor;

  /// Border Color for app.
  final Color? borderColor;

  /// Invert Color for app (Invert of `scaffoldBackgroundColor`).
  final Color? invertColor;

  const CHITheme({
    this.primaryColor,
    this.primaryLightColor,
    this.secondryColor,
    this.secondryLightColor,
    this.accentColor,
    this.selectedItemColor,
    this.cardColor,
    this.actionButtonColor,
    this.borderColor,
    this.invertColor,
  });

  // You must override the copyWith method.
  @override
  CHITheme copyWith({
    Color? primaryColor,
    Color? primaryLightColor,
    Color? secondryColor,
    Color? secondryLightColor,
    Color? accentColor,
    Color? selectedItemColor,
    Color? cardColor,
    Color? actionButtonColor,
    Color? borderColor,
    Color? invertColor,
  }) {
    return CHITheme(
      primaryColor: primaryColor ?? this.primaryColor,
      primaryLightColor: primaryLightColor ?? this.primaryLightColor,
      secondryColor: secondryColor ?? this.secondryColor,
      secondryLightColor: secondryLightColor ?? this.secondryLightColor,
      accentColor: accentColor ?? this.accentColor,
      selectedItemColor: selectedItemColor ?? this.selectedItemColor,
      cardColor: cardColor ?? this.cardColor,
      actionButtonColor: actionButtonColor ?? this.actionButtonColor,
      borderColor: borderColor ?? this.borderColor,
      invertColor: invertColor ?? this.invertColor,
    );
  }

  // You must override the lerp method.
  @override
  CHITheme lerp(ThemeExtension<CHITheme>? other, double t) {
    if (other is! CHITheme) {
      return this;
    }
    return CHITheme(
        primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
        primaryLightColor:
            Color.lerp(primaryLightColor, other.primaryLightColor, t),
        secondryColor: Color.lerp(secondryColor, other.secondryColor, t),
        secondryLightColor:
            Color.lerp(secondryLightColor, other.secondryLightColor, t),
        accentColor: Color.lerp(accentColor, other.accentColor, t),
        selectedItemColor:
            Color.lerp(selectedItemColor, other.selectedItemColor, t),
        cardColor: Color.lerp(cardColor, other.cardColor, t),
        actionButtonColor:
            Color.lerp(actionButtonColor, other.actionButtonColor, t),
        borderColor: Color.lerp(borderColor, other.borderColor, t),
        invertColor: Color.lerp(invertColor, other.invertColor, t));
  }
}
