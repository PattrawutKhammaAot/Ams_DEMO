import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {

  AppTheme._();


  static final lightTheme = ThemeData(
    fontFamily: 'Noto',
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 2.0,
      backgroundColor: Color(0xff3e5b7a),
      foregroundColor: Color(0xFFFFFFFF),
      // centerTitle: true,
      titleSpacing: 0.0,
      toolbarHeight: 56.0,
      actionsIconTheme: IconThemeData(
        color: Color(0xFFFFFFFF),
        size: 24.0,
        opacity: 1.0,
        fill: 1.0,
      ),
      iconTheme: IconThemeData(
        color: Color(0xFFFFFFFF),
        size: 24.0,
        opacity: 1.0,
        fill: 1.0,
      ),
      titleTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 18.0,
        height: 1.0,
      ),
      shadowColor: Color(0x991A1C1E),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      alignLabelWithHint: true,
      filled: true,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      isCollapsed: true,
      isDense: false,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xff3d5a79),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer:Color(0xFFD1E4FF),
      onPrimaryContainer:Color(0xFF001D36),
      secondary: Color(0xffff715b),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer:Color(0xFFD7E3F7),
      onSecondaryContainer:Color(0xFF101C2B),
      surface: Color(0xFF000000),
      onSurface: Color(0xFF1A1C1E),
      surfaceTint: Color(0xFFD1E4FF),
      surfaceVariant: Color(0xFF646870),
      onSurfaceVariant:Color(0xFF001D36),
      error: Color(0xffdd4b4b),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer:Color(0xFF001D36),
      tertiary: Color(0xff37516d),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer:Color(0xFFF2DAFF),
      onTertiaryContainer:Color(0xFF251431),
      outline: Color(0xff575757),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 16.0,
        color: Color(0xFF000000),
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        color: Color(0xFF000000),
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        color: Color(0xFF000000),
      ),
      titleLarge: TextStyle(
        fontSize: 16.0,
        color: Color(0xFF000000),
      ),
      titleMedium: TextStyle(
        fontSize: 14.0,
        color: Color(0xFF000000),
      ),
      titleSmall: TextStyle(
        fontSize: 12.0,
        color: Color(0xFF000000),
      ),
      labelLarge: TextStyle(
        fontSize: 14.0,
        color: Color(0xFF000000),
        letterSpacing: 1.0,
      ),
    ),
    tabBarTheme: const TabBarTheme(
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: Color(0xFFFFFFFF),
        labelColor: Color(0xFFFFFFFF),
        indicator: ShapeDecoration(
          shape: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF000000),
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
        )
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          const Color(0xff484848),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xFFFFFFFF),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          const Color(0xFFFFFFFF),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xffff725c),
        ),
        elevation: MaterialStateProperty.all<double>(
          0.0,
        ),
      ),
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: Color(0xffffffff),
      elevation: 3.0,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconSize: MaterialStateProperty.all<double>(
          16.0,
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xffff7059),
        ),
        iconColor: MaterialStateProperty.all<Color>(
          const Color(0xffffffff),
        ),
      ),
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(
        const Color(0xffc8c8c8),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xffff715b),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          const Color(0xFFFFFFFF),
        ),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all<Color>(
        const Color(0xff365269),
      ),
      overlayColor: MaterialStateProperty.all<Color>(
        const Color(0xFFFFFFFF),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xff355168),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all<Color>(
        const Color(0xFFFFFFFF),
      ),
      fillColor: MaterialStateProperty.all<Color>(
        const Color(0xFFFFFFFF),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: Color(0xFFFFFFFF),
      iconColor: Color(0xff364f69),
      selectedColor: Color(0xFFF1EFEF),
      horizontalTitleGap: 10.0,
      dense: true,
    ),
    cardTheme: const CardTheme(
      color: Color(0xff70859a),
      shadowColor: Color(0xFFFFFFFF),
      elevation: 4.0,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xff365269),
      elevation: 0.0,
      contentTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor:Color(0xFFFFFFFF),
      iconSize:16.0,
      backgroundColor:Color(0xffff715b),
      enableFeedback: true,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      elevation: 3.0,
      width: 330.0,
    ),
    dividerTheme: const DividerThemeData(
      indent: 3.0,
      endIndent: 3.0,
      thickness: 1.0,
      color: Color(0xfff5f5f5),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFFFFFFFF),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Color(0xFF000000),
        iconColor: Color(0xff36506c),
      ),
    ),
    badgeTheme: const BadgeThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      textColor: Color(0xff484848),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color(0xffffffff),
      elevation: 3.0,
      surfaceTintColor: Color(0xFFFFFFFF),
      height: 84.0,
    ),
    toggleButtonsTheme: const ToggleButtonsThemeData(
      fillColor: Color(0xffff735c),
      color: Color(0xff727272),
      selectedColor: Color(0xffffffff),
      borderColor: Color(0xFFBDBDBD),
    ),
    buttonBarTheme: const ButtonBarThemeData(
      buttonHeight: 36.0,
      buttonMinWidth: 64.0,
      buttonAlignedDropdown:true,
    ),
    visualDensity: VisualDensity.standard,
    unselectedWidgetColor: const Color(0x8a000000),
    dialogBackgroundColor: const Color(0xfffefcf3),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
      TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
    }),
  );



  static final darkTheme = ThemeData(
    fontFamily: 'Noto',
    scaffoldBackgroundColor: const Color(0xFF000000),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0.0,
      backgroundColor: Color(0xFF1A1C1E),
      foregroundColor: Color(0xFFFFFFFF),
      centerTitle: true,
      titleSpacing: 0.0,
      toolbarHeight: 56.0,
      actionsIconTheme: IconThemeData(
        color: Color(0xFFFFFFFF),
        size: 24.0,
        opacity: 1.0,
        fill: 1.0,
      ),
      iconTheme: IconThemeData(
        color: Color(0xFFFFFFFF),
        size: 24.0,
        opacity: 1.0,
        fill: 1.0,
      ),
      titleTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 24.0,
        height: 1.0,
      ),
      shadowColor: Color(0x991A1C1E),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      alignLabelWithHint: true,
      filled: true,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      isCollapsed: true,
      isDense: false,
      // floatingLabelBehavior: auto,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF9ECAFF),
      onPrimary: Color(0xFF003258),
      primaryContainer:Color(0xFF00497D),
      onPrimaryContainer:Color(0xFFD1E4FF),
      secondary: Color(0xFFBBC7DB),
      onSecondary: Color(0xFF253140),
      secondaryContainer:Color(0xFF3B4858),
      onSecondaryContainer:Color(0xFFD7E3F7),
      surface: Color(0xFF17191B),
      onSurface: Color(0xFFE2E2E6),
      surfaceTint: Color(0xFFDADDE2),
      surfaceVariant: Color(0xFFB0B3BA),
      onSurfaceVariant:Color(0xFFD1E4FF),
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF410002),
      onErrorContainer:Color(0xFFD1E4FF),
      tertiary: Color(0xFFD6BEE4),
      onTertiary: Color(0xFF3B2948),
      tertiaryContainer:Color(0xFF4A3956),
      onTertiaryContainer:Color(0xFFF2DAFF),
      outline: Color(0xFF9ECAFF),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 16.0,
        color: Color(0xFFFFFFFF),
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        color: Color(0xFFFFFFFF),
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        color: Color(0xFFFFFFFF),
      ),
      titleLarge: TextStyle(
        fontSize: 16.0,
        color: Color(0xFFFFFFFF),
      ),
      titleMedium: TextStyle(
        fontSize: 14.0,
        color: Color(0xFFFFFFFF),
      ),
      titleSmall: TextStyle(
        fontSize: 12.0,
        color: Color(0xFFFFFFFF),
      ),
      labelLarge: TextStyle(
        fontSize: 14.0,
        color: Color(0xFFFFFFFF),
        letterSpacing: 1.0,
      ),
    ),
    tabBarTheme: const TabBarTheme(
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: Color(0xFFFFFFFF),
        labelColor: Color(0xFFFFFFFF),
        indicator: ShapeDecoration(
          shape: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFFFFFFF),
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
        )
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          const Color(0xFFFFFFFF),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xFF000000),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          const Color(0xFFFFFFFF),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xFF1976D2),
        ),
        elevation: MaterialStateProperty.all<double>(
          0.0,
        ),
      ),
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: Color(0xFFFF5722),
      elevation: 3.0,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconSize: MaterialStateProperty.all<double>(
          16.0,
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0x00000000),
        ),
        iconColor: MaterialStateProperty.all<Color>(
          const Color(0xFFFFFFFF),
        ),
      ),
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(
        const Color(0xFF17CB21),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xFFCB4617),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          const Color(0xFFFFFFFF),
        ),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all<Color>(
        const Color(0xFFFFFFFF),
      ),
      overlayColor: MaterialStateProperty.all<Color>(
        const Color(0xFF000000),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFFFFFFF),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all<Color>(
        const Color(0xFFFFFFFF),
      ),
      fillColor: MaterialStateProperty.all<Color>(
        const Color(0xFFFFFFFF),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: Color(0xFF000000),
      iconColor: Color(0xFF1976D2),
      selectedColor: Color(0xA7221D1D),
      horizontalTitleGap: 10.0,
      dense: true,
    ),
    cardTheme: const CardTheme(
      color: Color(0xFFFFFFFF),
      shadowColor: Color(0xFF000000),
      elevation: 3.0,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      elevation: 0.0,
      contentTextStyle: TextStyle(
        color: Color(0xFF000000),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor:Color(0xFF000000),
      iconSize:16.0,
      backgroundColor:Color(0xFFFFFFFF),
      enableFeedback: true,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFF1A1C1E),
      elevation: 3.0,
      width: 330.0,
    ),
    dividerTheme: const DividerThemeData(
      indent: 3.0,
      endIndent: 3.0,
      thickness: 1.0,
      color: Color(0xFFFFFFFF),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF000000),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Color(0xFFFFFFFF),
        iconColor: Color(0xFF1976D2),
      ),
    ),
    badgeTheme: const BadgeThemeData(
      backgroundColor: Color(0x00000000),
      textColor: Color(0xFFFFFFFF),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color(0xFF1A1C1E),
      elevation: 3.0,
      surfaceTintColor: Color(0xFF000000),
      height: 84.0,
    ),
    toggleButtonsTheme: const ToggleButtonsThemeData(
      fillColor: Color(0xFF000000),
      color: Color(0xFF42A5F5),
      selectedColor: Color(0xFF1976D2),
      borderColor: Color(0xFFFFFFFF),
    ),
    buttonBarTheme: const ButtonBarThemeData(
      buttonHeight: 36.0,
      buttonMinWidth: 64.0,
      buttonAlignedDropdown:true,
    ),
    visualDensity: VisualDensity.standard,
    unselectedWidgetColor: const Color(0x8a000000),
    dialogBackgroundColor: const Color(0xfffefcf3),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
      TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
    }),
  );


}
