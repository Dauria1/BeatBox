import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final EdgeInsets margin;
  final String Function(String value) validator;
  final bool obscureText;
  final TextEditingController controller;
  final String placeholder;

  CustomInput(
      {this.margin,
      @required this.validator,
      this.obscureText = false,
      @required this.controller,
      @required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: MediaQuery.of(context).size.width * 0.65,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: placeholder,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        obscureText: obscureText,
        validator: validator,
        controller: controller,
      ),
    );
  }
}
