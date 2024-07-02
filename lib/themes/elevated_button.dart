import 'package:crud_operation_flutter/utils/app_color.dart';
import 'package:flutter/material.dart';

ElevatedButtonThemeData getElevatedButtonThemeData() => ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.appBar,
        foregroundColor: AppColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
