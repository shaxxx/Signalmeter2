import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class Hyperlink extends StatelessWidget {
  final String url;
  final String text;
  final double fontSize;
  final Color color;

  Hyperlink({
    @required this.url,
    @required this.text,
    this.fontSize,
    this.color,
  })  : assert(text != null),
        assert(url != null);

  _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontSize: fontSize,
          color: color,
        ),
      ),
      onTap: _launchURL,
    );
  }
}
