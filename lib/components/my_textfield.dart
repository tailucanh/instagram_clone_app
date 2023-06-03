import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final TextInputType textInputType;
  final bool obscureText;
  final IconData iconData;
  final InkWell? inkWell;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.textInputType,
    required this.obscureText,
    required this.iconData,
    this.inkWell,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      child: TextField(
        keyboardType: textInputType,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(
            iconData,
            color: Color.fromRGBO(234, 64, 128, 100),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: Colors.grey.shade50,
          filled: true,
          hintText: hintText,
          suffix: inkWell,
        ),
      ),
    );
  }
}
