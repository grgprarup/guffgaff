import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final double height;
  final String labelText;
  final RegExp validationRegEx;
  final bool obscureText;
  final Widget? suffixIcon;
  final void Function(String?) onSaved;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;

  const CustomFormField({
    super.key,
    required this.height,
    required this.labelText,
    required this.validationRegEx,
    required this.onSaved,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        onChanged: onChanged,
        onSaved: onSaved,
        obscureText: obscureText,
        validator: validator ??
            (value) {
              if (value!.isEmpty) {
                return '$labelText is required.';
              } else if ((labelText == 'Password' ||
                      labelText == 'Confirm Password') &&
                  !validationRegEx.hasMatch(value)) {
                return 'Password must contain at least one lowercase, uppercase letter, number, special character, and must be 8 characters long';
              } else if (!validationRegEx.hasMatch(value)) {
                return 'Enter a valid ${labelText.toLowerCase()}';
              }
              return null;
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
