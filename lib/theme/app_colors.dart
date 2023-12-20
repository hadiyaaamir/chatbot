part of 'theme.dart';

class AppColors {
  ColorScheme get colorSchemeLight => ColorScheme.light(
        primary: coral,
        onPrimary: white,
        inversePrimary: lightCoral,
        primaryContainer: lightGrey,
        onPrimaryContainer: darkerGrey,
        secondaryContainer: veryLightCoral,
        background: veryLightGrey,
        onBackground: veryDarkGrey,
        secondary: blue,
        onSecondary: white,
        outline: grey,
        outlineVariant: darkerGrey,
      );

  Color coral = const Color(0xFFff8444);
  Color lightCoral = const Color(0xFFffdac7);
  Color veryLightCoral = const Color(0xFFfff3ec);

  Color blue = const Color(0xFF00344e);

  Color veryDarkGrey = const Color(0xFF101010);
  Color darkerGrey = const Color(0xFF595C60);
  Color darkGrey = const Color(0xFF8F9399);
  Color grey = const Color(0xFFafb4be);
  Color lightGrey = const Color(0xFFf3f4f6);
  Color veryLightGrey = const Color(0xFFfbfbfb);

  Color white = const Color(0xFFffffff);
}
