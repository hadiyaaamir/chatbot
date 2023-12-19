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
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          surfaceTintColor: colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: colors.lightGrey,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          hintStyle: TextStyle(color: colors.grey),
          suffixIconColor: colors.darkGrey,
          prefixIconColor: colors.darkGrey,
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
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            backgroundColor: colors.white,
            foregroundColor: colors.coral,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(color: colors.coral, width: 1.5),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            surfaceTintColor: Colors.transparent,
            backgroundColor: colors.coral,
            foregroundColor: colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: colors.veryLightGrey,
          toolbarHeight: 40,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        iconTheme: IconThemeData(color: colors.darkGrey),
      );
}
