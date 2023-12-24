part of '../local_pub.dart';

abstract class CHIStyles {
  //PRIMARY COLORS
  static Color primaryColor = const Color(0xffE76E68);
  static Color primaryLightColor = const Color(0xffFFF1F0);
  static Color secondryColor = const Color(0xff4F71AF);
  static Color secondryLightColor = const Color(0xffF3F7FF);
  static Color accentColor = const Color(0xffF2DA5F);

//GREY COLORS
  static Color cardBorderColor = const Color(0xfff2f4f7);
  static Color greyColor = const Color(0xff798287);
  static Color lightGreyColor = const Color(0xffDADADA);

// Color primaryTextColor = const Color(0xff1d2939);
  // static Color primaryTextColor = const Color(0xff333238);
  static Color iconColor = const Color(0xff174571);

//ERROR COLORS

  static Color whiteColor = Colors.white;
  static Color appBgColor = const Color(0xfffcfcfd);
  static Color chatBubbleTextClr =
      const Color(0xff667085); // using for custom_Subscription_vu...
  static Color cardColor = const Color(0xffF3F7FF);
  static Color checkboxTextColor = Colors.black;
  static Color scaffoldLBackgroundColor = const Color(0xffFCFCFD);
  static Color scaffoldDBackgroundColor = const Color(0xff121212);

  static Color darkSuccessColor = const Color(0xff05603A);
  static Color primarySuccessColor = const Color(0xff12B76A);
  static Color lightSuccessColor = const Color(0xffD1FADF);
  static Color darkErrorColor = const Color(0xff912018);
  static Color primaryErrorColor = const Color(0xfff04438);
  static Color lightErrorColor = const Color(0xfffee4e2);
  static Color primaryWraningColor = const Color(0xffF79009);
  static Color lightWraningColor = const Color(0xffFEF0C7);
  static Color primaryPurpleColor = const Color(0xff9E77ED);
  static Color lightPurpleColor = const Color(0xffF4EBFF);

//WARNING COLORS
  // static Color darkWarningColor = const Color(0xff05603A);
  static Color primaryWarningColor = const Color(0xfff79009);
  static Color lightWarningColor = const Color(0xffFEF0C7);

//TEXT STYLES

// BORDERS
  static OutlineInputBorder chiOutlineBorder =
      const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));
  static Border? cardBorder = Border.all(color: cardBorderColor, width: 1.0);
  static BorderRadius cardRadius = BorderRadius.circular(16);

// Shadow
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      offset: const Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
      color: const Color(0xff101828).withOpacity(0.05),
    ),
  ];
  static TextStyle displayXsBoldStyle =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.w700);
  static TextStyle displayXsSemiBoldStyle =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
  static TextStyle displayXsMediumStyle =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.w500);
  static TextStyle displayXsNormalStyle =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.w400);
  static TextStyle xlBoldStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w700);
  static TextStyle xlSemiBoldStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  static TextStyle xlMediumStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
  static TextStyle xlNormalStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w400);
  static TextStyle lgBoldStyle =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w700);
  static TextStyle lgSemiBoldStyle =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  static TextStyle lgMediumStyle =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  static TextStyle lgNormalStyle =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
  static TextStyle mdBoldStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
  static TextStyle mdSemiBoldStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  static TextStyle mdMediumStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static TextStyle mdNormalStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  static TextStyle smBoldStyle =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w700);
  static TextStyle smSemiBoldStyle =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
  static TextStyle smMediumStyle =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  static TextStyle smNormalStyle =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  static TextStyle xsBoldStyle =
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w700);
  static TextStyle xsSemiBoldStyle =
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
  static TextStyle xsMediumStyle =
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  static TextStyle xsNormalStyle =
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
}
