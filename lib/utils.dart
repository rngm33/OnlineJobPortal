import 'package:flutter/material.dart';
class Utils{
  BuildContext? ctx;

  Utils(BuildContext context){
    ctx= context;
  }

  void showSnackbar(String msg,int duration) {
    final snackbar =  SnackBar(
      content:  Text(msg),
      duration:  Duration(seconds: duration),
      backgroundColor: Colors.redAccent,
      shape:  RoundedRectangleBorder(
          borderRadius:  BorderRadius.circular(1)),
    );
    ScaffoldMessenger.of(ctx!).showSnackBar(snackbar);
  }
}