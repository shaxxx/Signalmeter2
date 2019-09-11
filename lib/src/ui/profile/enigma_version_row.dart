import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'profile_widget.dart';

class EnigmaVersionRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: theme.hintColor),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Radio(
                    groupValue: ProfileWidget.of(context).profile.enigma,
                    value: EnigmaType.enigma1,
                    onChanged: (value) {
                      ProfileWidget.of(context).setEnigmaType(value);
                    },
                  ),
                  Text(
                    'Enigma1',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: theme.hintColor),
                  ),
                  Radio(
                    groupValue: ProfileWidget.of(context).profile.enigma,
                    value: EnigmaType.enigma2,
                    onChanged: (value) {
                      ProfileWidget.of(context).setEnigmaType(value);
                    },
                  ),
                  Text(
                    'Enigma2',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: theme.hintColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
