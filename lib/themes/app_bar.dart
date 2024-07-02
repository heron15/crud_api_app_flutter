import 'package:crud_operation_flutter/utils/app_color.dart';
import 'package:flutter/material.dart';

AppBarTheme getAppBarTheme() => const AppBarTheme(
      backgroundColor: AppColor.appBar,
      foregroundColor: AppColor.white,
      titleTextStyle: TextStyle(
        color: AppColor.white,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
    );
