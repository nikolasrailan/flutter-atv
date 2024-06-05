import 'package:flutter/material.dart';

part 'color_schemes.g.dart';

ThemeData get myTheme => ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: _lightColorScheme.primary,
        iconTheme: IconThemeData(
          color: _lightColorScheme.onPrimary,
        ),
        titleTextStyle: TextStyle(
          color: _lightColorScheme.onPrimary,
          fontSize: 22,
        ),
      ),
      // floatingActionButtonTheme: FloatingActionButtonThemeData(
      //   backgroundColor: _lightColorScheme.primaryContainer,
      // ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     backgroundColor: _lightColorScheme.primary,
      //     foregroundColor: _lightColorScheme.onPrimary,
      //   ),
      // ),
      // iconTheme: IconThemeData(
      //   color: _lightColorScheme.primary,
      // ),
    );
