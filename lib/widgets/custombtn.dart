import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final String btnTxt;
  final Color color;
  final Color txtColor;
  final Color borderColor;

  CustomBtn(
      {@required this.onPressed,
      @required this.btnTxt,
      this.color,
      this.txtColor,
      this.borderColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.circular(12)),
      color: color,
      textColor: txtColor,
      padding: const EdgeInsets.all(14.0),
      child: Text(btnTxt),
    );
  }
}
