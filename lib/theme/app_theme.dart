part of 'theme.dart';

class AppTheme {
  final AppColors colors = AppColors();
  final AppTextStyles textStyles = AppTextStyles();

  ThemeData get appTheme => ThemeData(
        useMaterial3: true,
        colorScheme: colors.colorSchemeLight,
        textTheme: textStyles.textTheme,
        disabledColor: colors.veryLightGrey,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colors.coral,
          foregroundColor: colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: colors.lightGrey,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          hintStyle: TextStyle(color: colors.grey),
          suffixIconColor: colors.darkGrey,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide.none,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedItemColor: colors.grey,
          selectedIconTheme: const IconThemeData(size: 25),
          selectedLabelStyle: textStyles.labelMedium,
          unselectedIconTheme: const IconThemeData(size: 25),
          unselectedLabelStyle: textStyles.labelSmall,
        ),
      );
}
