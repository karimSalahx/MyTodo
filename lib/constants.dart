import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  static const emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static void showErrorSnackBar(
      {@required BuildContext context, @required String content}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text(
        content,
        style: TextStyle(color: Colors.white),
      ),
    ));
  }

  static const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
}
