import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custombtn.dart';

class CustomActionButton extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;

  CustomActionButton({@required this.onCancel, @required this.onSave});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomBtn(
          onPressed: onCancel,
          btnTxt: "Cancel",
        ),
        CustomBtn(
          onPressed: onSave,
          btnTxt: "Save",
          color: Theme.of(context).accentColor,
          txtColor: Colors.white,
        )
      ],
    );
  }
}
