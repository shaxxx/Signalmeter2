import 'package:enigma_signal_meter/src/constants.dart';
import 'package:enigma_signal_meter/src/message_provider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SnackbarHandler {
  static bool isShowing = false;
  static List<Flushbar> snackBars = List<Flushbar>();

  static Future showInfoSnackBar(
    BuildContext context,
    String message,
  ) async {
    var snackBar = Flushbar(
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      duration: infoMessageDuration,
      leftBarIndicatorColor: Colors.blue[300],
    );
    await _showSnackbar(context, snackBar);
  }

  static Future showWarningSnackBar(
    BuildContext context,
    String message,
  ) async {
    var snackBar = Flushbar(
      message: message,
      icon: Icon(
        Icons.warning,
        size: 28.0,
        color: Colors.yellow[300],
      ),
      duration: warningMessageDuration,
      leftBarIndicatorColor: Colors.yellow[300],
    );
    await _showSnackbar(context, snackBar);
  }

  static Future showErrorSnackBar(
    BuildContext context,
    String message,
    String detailsMessage,
  ) async {
    var snackBar = Flushbar(
      message: message,
      icon: Icon(
        Icons.error,
        size: 28.0,
        color: Colors.red[300],
      ),
      duration: errorMessageDuration,
      leftBarIndicatorColor: Colors.red[300],
      mainButton: detailsMessage == null
          ? null
          : FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: Text(
                MessageProvider.of(context).details.toUpperCase(),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          MessageProvider.of(context).titleError.toUpperCase(),
                        ),
                        content: Text(detailsMessage),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              MessageProvider.of(context).close.toUpperCase(),
                            ),
                          )
                        ],
                      );
                    });
              }),
    );
    await _showSnackbar(context, snackBar);
  }

  static Future _showSnackbar(
    BuildContext context,
    Flushbar snackBar,
  ) async {
    snackBars.add(snackBar);

    if (isShowing) {
      return;
    }
    isShowing = true;
    while (snackBars.length > 0) {
      //take first message in queue
      var s = snackBars.first;
      //pop the message
      snackBars.remove(s);
      //show the message
      await s.show(context).timeout(
        //set timeout because if widget is not visible show() event will never end
        Duration(
          seconds: s.duration.inSeconds + 1,
        ),
        onTimeout: () {
          if (s.isDismissible) {
            //dismiss invisible snackbar with status SHOWING (is this a bug?)
            s.dismiss();
            //reschedule snackbar to be shown again
            //snackBars.add(s);
          }
          return Future.value(null);
        },
      );
    }
    isShowing = false;
  }
}
