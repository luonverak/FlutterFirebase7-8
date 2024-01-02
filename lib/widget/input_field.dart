import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField({
    super.key,
    this.border,
    this.prefixIcon,
    required this.hintText,
    this.maxLines,
    required this.controller,
    this.suffixIcon,
    this.obscureText,
  });
  double? border;
  Icon? prefixIcon;
  IconButton? suffixIcon;
  var hintText;
  var maxLines;
  var controller = TextEditingController();
  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(border!),
        border: Border.all(width: 2, color: Colors.blue),
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        maxLines: maxLines,
        obscureText: obscureText!,
      ),
    );
  }
}
