import 'package:flutter/material.dart';
import 'package:zekrayaty_app/common/presentation/widgets/loading_widget.dart';

// LoadingDialog class for displaying a loading dialog
class LoadingDialog {
  // Method to display the loading dialog
  static Future<void> displayLoadingDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return LoadingWidget();
        });
  }
}
