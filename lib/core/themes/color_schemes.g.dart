//import 'package:flutter/material.dart';
part of 'themes.dart';

const _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF004d00), // Verde Principal
  onPrimary: Color(0xFFFFFFFF), // Branco para texto sobre o verde
  primaryContainer: Color(0xFF66c466), // Verde Claro
  onPrimaryContainer:
      Color(0xFF004d00), // Verde Principal para texto sobre o verde claro
  secondary: Color(0xFF004d00), // Verde Principal
  onSecondary: Color(0xFFFFFFFF), // Branco
  secondaryContainer: Color(0xFF66c466), // Verde Claro
  onSecondaryContainer: Color(0xFF004d00), // Verde Principal
  tertiary: Color(0xFF004d00), // Verde Principal
  onTertiary: Color(0xFFFFFFFF), // Branco
  tertiaryContainer: Color(0xFF66c466), // Verde Claro
  onTertiaryContainer: Color(0xFF004d00), // Verde Principal
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFF2F2F2), // Cinza Claro
  onBackground: Color(0xFF1F1F1F),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF1F1F1F),
  surfaceVariant: Color(0xFFE7E0E0),
  onSurfaceVariant: Color(0xFF49454F),
  outline: Color(0xFF79747E),
  onInverseSurface: Color(0xFFF2F0F0),
  inverseSurface: Color(0xFF313033),
  inversePrimary: Color(0xFF66c466), // Verde Claro
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF004d00), // Verde Principal
  outlineVariant: Color(0xFFD7C8C2),
  scrim: Color(0xFF000000),
);

const _darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF66c466), // Verde Claro
  onPrimary: Color(0xFF004d00), // Verde Principal
  primaryContainer: Color(0xFF004d00), // Verde Principal
  onPrimaryContainer: Color(0xFF66c466), // Verde Claro
  secondary: Color(0xFF66c466), // Verde Claro
  onSecondary: Color(0xFF004d00), // Verde Principal
  secondaryContainer: Color(0xFF004d00), // Verde Principal
  onSecondaryContainer: Color(0xFF66c466), // Verde Claro
  tertiary: Color(0xFF66c466), // Verde Claro
  onTertiary: Color(0xFF004d00), // Verde Principal
  tertiaryContainer: Color(0xFF004d00), // Verde Principal
  onTertiaryContainer: Color(0xFF66c466), // Verde Claro
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF1F1F1F),
  onBackground: Color(0xFFE4E1E6),
  surface: Color(0xFF1F1F1F),
  onSurface: Color(0xFFE4E1E6),
  surfaceVariant: Color(0xFF49454F),
  onSurfaceVariant: Color(0xFFCFC6D9),
  outline: Color(0xFF938F99),
  onInverseSurface: Color(0xFF1F1F1F),
  inverseSurface: Color(0xFFE4E1E6),
  inversePrimary: Color(0xFF004d00), // Verde Principal
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF66c466), // Verde Claro
  outlineVariant: Color(0xFF625B71),
  scrim: Color(0xFF000000),
);
