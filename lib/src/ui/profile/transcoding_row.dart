import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../message_provider.dart';
import 'profile_widget.dart';

class TranscodingRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: theme.hintColor),
        ),
        child: Row(
          children: <Widget>[
            Text(
              MessageProvider.of(context).profileTranscodingEnable,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: theme.hintColor,
                fontSize: 16,
              ),
            ),
            Checkbox(
              value: ProfileWidget.of(context).profile.transcoding,
              onChanged: (value) {
                ProfileWidget.of(context).setTranscoding(value);
              },
            )
          ],
        ),
      ),
    );
  }
}
