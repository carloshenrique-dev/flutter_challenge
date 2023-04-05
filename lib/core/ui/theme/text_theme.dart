import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Hubot',
            fontSize: 18,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Hubot',
            fontSize: 16,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Hubot',
            fontSize: 14,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Hubot',
            fontSize: 18,
          ),
          titleMedium: TextStyle(
            fontFamily: 'Hubot',
            fontSize: 16,
          ),
          titleSmall: TextStyle(
            fontFamily: 'Hubot',
            fontSize: 14,
          ),
          labelLarge: TextStyle(
            fontFamily: 'Hubot',
            fontSize: 16,
          ),
        ),
      );
}
