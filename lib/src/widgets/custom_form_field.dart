import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final double height;
  final String labelText;
  final RegExp validationRegEx;
  final bool obscureText;
  final Widget? suffixIcon;
  final void Function(String?) onSaved;

  const CustomFormField(
      {super.key,
      required this.height,
      required this.labelText,
      required this.validationRegEx,
      required this.onSaved,
      this.obscureText = false,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        onSaved: onSaved,
        obscureText: obscureText,
        validator: (value) {
          if (value!=null && validationRegEx.hasMatch(value)) {
            return null;
          }
          return 'Enter a valid ${labelText.toLowerCase()}';
        },
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
