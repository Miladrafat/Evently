import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogUtiles {
  static Future<void> showloadingdialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 10),
              Text("Loading...")
            ],
          ),
        );
      },
    );
  }
  static showMessagedialog(BuildContext context, String message) {
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              Expanded(child: Text(message)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text("Ok"),
            )
          ],
        );
      },
    );
  }
  static showToastmessage(BuildContext context,String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
