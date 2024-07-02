import 'package:crud_operation_flutter/utils/app_color.dart';
import 'package:flutter/material.dart';

InputDecorationTheme getInputDecorationTheme() => InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.all(18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColor.black,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColor.green,
          width: 2,
        ),
      ),
    );
