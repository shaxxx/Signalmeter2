import 'package:enigma_signal_meter/src/ui/profile/form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaddedFormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool isNumeric;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final int? maxLength;

  const PaddedFormTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.validator,
    this.maxLength,
    this.isPassword = false,
    this.isNumeric = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: FormTextField(
        controller: controller,
        hintText: hintText,
        labelText: labelText,
        isNumeric: isNumeric,
        isPassword: isPassword,
        validator: validator,
        maxLength: maxLength,
      ),
    );
  }
}
