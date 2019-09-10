import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool isNumeric;
  final String labelText;
  final String Function(String) validator;
  final int maxLength;
  const FormTextField({
    Key key,
    @required this.controller,
    @required this.hintText,
    @required this.labelText,
    @required this.validator,
    this.maxLength,
    this.isPassword = false,
    this.isNumeric = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      autocorrect: false,
      controller: controller,
      obscureText: isPassword,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      cursorRadius: Radius.circular(20),
      validator: validator,
      maxLength: maxLength,
      inputFormatters: isNumeric
          ? <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly]
          : null,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
