import 'package:enigma_signal_meter/src/constants.dart';
import 'package:enigma_signal_meter/src/ui/common/hyperlink.dart';
import 'package:enigma_signal_meter/src/ui/common/scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../../message_provider.dart';

class AboutView extends StatefulWidget {
  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  PackageInfo _packageInfo;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_packageInfo == null) {
      var info = await PackageInfo.fromPlatform();
      setState(() {
        _packageInfo = info;
      });
    }
  }

  Widget _getBuildNumber(BuildContext context) {
    if (_packageInfo == null) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Text(
        MessageProvider.of(context).build + ':  ' + _packageInfo.buildNumber,
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  Widget _getVersion(BuildContext context) {
    if (_packageInfo == null) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        MessageProvider.of(context).version + ':  ' + _packageInfo.version,
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ScaffoldBackground(
      backgroundColor: theme.primaryColor.withOpacity(0.3),
      appBar: AppBar(
        title: Text(MessageProvider.of(context).actionAbout),
        backgroundColor: theme.primaryColor.withOpacity(0.6),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                MessageProvider.of(context).appName,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _getVersion(context),
            _getBuildNumber(context),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(MessageProvider.of(context).informationsSupport),
            ),
            Hyperlink(
              url: krkadoniUrl,
              text: krkadoniUrl,
              fontSize: 20,
              color: theme.accentColor.withOpacity(0.7),
            ),
            Container(
              padding: EdgeInsets.only(top: 18, bottom: 5),
              child: Text(
                MessageProvider.of(context).specialThanksGoesTo,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Text(
              'Bosnian Pharao | GigaBlue',
              style: TextStyle(
                color: theme.accentColor.withOpacity(0.7),
                fontSize: 17,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(MessageProvider.of(context).thanksForTestingTo),
            ),
            Hyperlink(
              url: satelitskiForumUrl,
              text: satelitskiForumUrl,
              fontSize: 17,
              color: theme.accentColor.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }
}
