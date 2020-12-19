import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTxtField extends StatelessWidget {
  final String labelTxt;
  final TextEditingController controller;

  CustomTxtField({@required this.labelTxt, this.controller});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          labelText: labelTxt),
    );
  }
}
