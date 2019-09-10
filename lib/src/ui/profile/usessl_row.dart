import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../message_provider.dart';
import 'profile_widget.dart';

class UseSslRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).hintColor),
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    MessageProvider.of(context).profileUseSsl,
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 16,
                    ),
                  ),
                  Checkbox(
                    value: ProfileWidget.of(context).profile.useSsl,
                    onChanged: (value) {
                      ProfileWidget.of(context).setUseSsl(value);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
