import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAdaptiveProgressIndicator extends StatelessWidget {
  const PlatformAdaptiveProgressIndicator() : super();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 30,
        height: 30,
        child: Platform.isIOS
            ? const CupertinoActivityIndicator()
            : const CircularProgressIndicator(),
      ),
    );
  }
}
