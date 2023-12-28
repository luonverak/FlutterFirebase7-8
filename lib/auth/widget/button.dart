import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({
    super.key,
    this.radius,
    this.color,
    this.text,
  });
  double? radius;
  Color? color;
  var text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius!),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
