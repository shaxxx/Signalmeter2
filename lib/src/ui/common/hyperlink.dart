import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class Hyperlink extends StatelessWidget {
  final String url;
  final String text;
  final double? fontSize;
  final Color? color;

  const Hyperlink({super.key, 
    required this.url,
    required this.text,
    this.fontSize,
    this.color,
  });

  Future _launchURL() async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchURL,
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontSize: fontSize,
          color: color,
        ),
      ),
    );
  }
}
