import 'package:flutter/material.dart';
import 'package:todo/src/utlis/constant/colors.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      
      onPressed: onPressed,
      color: ConstColors.secondaryColor,
      child: Text(text),
    );
  }
}
