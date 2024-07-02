import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validatorText,
    required this.inputType,
  });

  final TextEditingController controller;
  final String hintText;
  final String validatorText;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? value) {
        if (value == null || value.trim().isEmpty) {
          return validatorText;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
