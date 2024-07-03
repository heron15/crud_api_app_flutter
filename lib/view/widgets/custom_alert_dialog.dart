import 'package:crud_operation_flutter/utils/app_color.dart';
import 'package:flutter/material.dart';

Future<dynamic> customAlertDialog(
  BuildContext context,
  String title,
  VoidCallback noButton,
  VoidCallback yesButton,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: AppColor.white,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColor.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              noButton();
            },
            child: const Text(
              'No',
              style: TextStyle(color: AppColor.appBar),
            ),
          ),
          TextButton(
            onPressed: () {
              yesButton();
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: AppColor.appBar),
            ),
          ),
        ],
      );
    },
  );
}
