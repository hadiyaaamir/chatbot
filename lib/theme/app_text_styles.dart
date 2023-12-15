part of 'theme.dart';

class AppTextStyles {
  final AppColors colors = AppColors();

  final double tinyFont = 10;
  final double smallFont = 11;
  final double regularFont = 12;
  final double largeFont = 14;

  TextTheme get textTheme => TextTheme(
        labelSmall: labelSmall,
        labelMedium: labelMedium,
        bodySmall: bodySmall,
      );

  TextStyle get labelSmall => TextStyle(
        fontSize: tinyFont,
        fontWeight: FontWeight.w600,
      );

  TextStyle get labelMedium => TextStyle(
        fontSize: smallFont,
        fontWeight: FontWeight.w600,
      );

  TextStyle get bodySmall => TextStyle(
        fontSize: smallFont,
        color: colors.darkGrey,
      );
}
