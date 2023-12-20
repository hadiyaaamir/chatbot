part of 'theme.dart';

class AppTextStyles {
  final AppColors colors = AppColors();

  final double tinyFont = 10;
  final double smallFont = 11;
  final double regularFont = 13;
  final double largeFont = 14;
  final double xLargeFont = 18;
  final double hugeFont = 24;

  Color get _lighterTextColor => colors.darkGrey;

  TextTheme get textTheme => TextTheme(
        labelSmall: labelSmall,
        labelMedium: labelMedium,
        labelLarge: labelLarge,
        bodySmall: bodySmall,
        bodyMedium: bodyMedium,
        bodyLarge: bodyLarge,
        titleSmall: titleSmall,
        titleMedium: titleMedium,
        titleLarge: titleLarge,
        headlineSmall: headlineSmall,
        headlineMedium: headlineMedium,
      );

  TextStyle get labelSmall => TextStyle(
        fontSize: tinyFont,
        fontWeight: FontWeight.w600,
        color: _lighterTextColor,
      );

  TextStyle get labelMedium => TextStyle(
        fontSize: smallFont,
        fontWeight: FontWeight.w600,
        color: _lighterTextColor,
      );

  TextStyle get labelLarge => TextStyle(
        fontSize: regularFont,
        fontWeight: FontWeight.w600,
        color: _lighterTextColor,
      );

  TextStyle get bodySmall => TextStyle(
        fontSize: smallFont,
        color: _lighterTextColor,
      );

  TextStyle get bodyMedium => TextStyle(
        fontSize: regularFont,
        color: _lighterTextColor,
        fontWeight: FontWeight.w500,
      );

  TextStyle get bodyLarge => TextStyle(
        fontSize: largeFont,
        color: _lighterTextColor,
        fontWeight: FontWeight.w500,
      );

  TextStyle get titleSmall => TextStyle(fontSize: regularFont);
  TextStyle get titleMedium => TextStyle(fontSize: largeFont);
  TextStyle get titleLarge => TextStyle(
        fontSize: xLargeFont,
        fontWeight: FontWeight.w700,
      );

  TextStyle get headlineSmall => TextStyle(
        fontSize: largeFont,
        fontWeight: FontWeight.w700,
      );

  TextStyle get headlineMedium => TextStyle(
        fontSize: hugeFont,
        fontWeight: FontWeight.w700,
      );
}
