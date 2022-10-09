import 'package:bni_attendance/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils{
  static showSnackBar(BuildContext context, String content){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content, style: TextStyle(color: Colors.black),),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Colors.white,
      margin: EdgeInsets.only(
          bottom: Constants.height! - Constants.height! * 0.2,
          right: 20,
          left: 20),
    ));
  }

}