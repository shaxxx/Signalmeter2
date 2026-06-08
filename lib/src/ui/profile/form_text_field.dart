import 'package:enigma_signal_meter/src/ui/profile/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool isNumeric;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  const FormTextField({
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
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : null,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onFieldSubmitted: (_) => ProfileWidget.of(context).focusNode.nextFocus(),
      textInputAction: TextInputAction.next,
    );
  }
}
