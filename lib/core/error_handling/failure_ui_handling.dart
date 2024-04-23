import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:zekrayaty_app/theme.dart';

class FailureUiHandling {
  static void showToast({
    required BuildContext context,
    required String errorMsg,
    Color color = Colors.red,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: errorMsg,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: OwnTheme.Red,
      textColor: Colors.white,
      fontSize: 14.sp,
    );
  }

  static Widget centeredMessageBuilder(String message) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: AutoSizeText(
          message,
          maxLines: 4,
          textAlign: TextAlign.center,
          style: OwnTheme.bodyTextStyle(),
        ),
      ),
    );
  }

  static Widget mediaFailureWidget(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error),
          Text(
            "Try again",
            style: OwnTheme.bodyTextStyle(),
          ),
        ],
      ),
    );
  }
}
