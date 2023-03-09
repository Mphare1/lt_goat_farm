import 'package:flutter/material.dart';
import 'constants.dart';

const Color kPrimaryColor = Color(0xFF00ADEF);

class RoundedInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final TextInputType keyboardType;
  final Function()? onTap;

  const RoundedInputField({
    Key? key,
    required this.controller,
    required this.label,
    this.icon,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon, color: kPrimaryColor) : null,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      onTap: onTap,
    );
  }
}
