import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const defaultPadding = 16.0;
const cartBarHeight = 95.0;
const headerHeight = 85.0;

const bgColor = Color(0xFFF6F5F2);
const primaryColor = Color(0xFF00BD56);

const panelTransition = Duration(milliseconds: 500);

const appUrl = "https://zero-fitness01.netlify.app";


void showNoInternetToast(msg, tColor, bColor) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: bColor,
    textColor: tColor,
    fontSize: 16.0,
  );
}