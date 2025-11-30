import 'package:flutter/material.dart';
import 'package:travel_hub/constant.dart';


class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool obscureText;
  final IconData? suffixIcon;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.icon,
    required this.label,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboard,
    this.validator,
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        labelText: label,
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(width * 0.03),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kBackgroundColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kBackgroundColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: keyboard,
      
    );
  }
}
