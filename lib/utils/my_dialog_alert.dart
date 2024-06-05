import 'package:flutter/material.dart';

class MyDialogAlert {
  static void showMyAlertDialog({required BuildContext context, required String title,
    required String message, List<Widget> ? actions, bool barrierDissm = false,
    Color color = Colors.amber,String textHideDialog = 'Hide'}) {
    showDialog(
        context: context,
        barrierDismissible: barrierDissm,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: actions ?? <Widget>[TextButton(
                onPressed: () => Navigator.pop(context), child: Text(textHideDialog)),
            ],
            backgroundColor: color,
          );
        });
  }



  static void showAlertDialogContent({required BuildContext context, required String title,bool showActions = true,
    List<Widget> ? actions, bool barrierDissm = false, Color color = Colors.amber,
    String textHideDialog = 'Hide',Widget content = const Text('Content')}) {

    if(!showActions){
      showDialog(
          context: context,
          barrierDismissible: barrierDissm,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: content,
              backgroundColor: color,
            );
          });
      }

    showDialog(
        context: context,
        barrierDismissible: barrierDissm,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: content,
            actions: actions ?? <Widget>[TextButton(
              onPressed: () => Navigator.pop(context), child: Text(textHideDialog)),
              ],
            backgroundColor: color,
          );
        });
  }

}


