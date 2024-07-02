import 'package:crud_operation_flutter/themes/elevated_button.dart';
import 'package:crud_operation_flutter/themes/text_form_field.dart';
import 'package:crud_operation_flutter/utils/app_route.dart';
import 'package:crud_operation_flutter/themes/app_bar.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: getAppBarTheme(),
        inputDecorationTheme: getInputDecorationTheme(),
        elevatedButtonTheme: getElevatedButtonThemeData(),
      ),
      initialRoute: AppRoute.home,
      onGenerateRoute: AppRoute.generateRoute,
    );
  }
}
