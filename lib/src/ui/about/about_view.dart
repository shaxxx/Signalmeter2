import 'package:enigma_signal_meter/src/constants.dart';
import 'package:enigma_signal_meter/src/ui/common/hyperlink.dart';
import 'package:enigma_signal_meter/src/ui/common/scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Widget _getVersion(BuildContext context) {
    if (_packageInfo == null) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Text(
        MessageProvider.of(context).version + ':  ' + _packageInfo.buildNumber,
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  Widget _getRelease(BuildContext context) {
    if (_packageInfo == null) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        MessageProvider.of(context).releaseName + ':  ' + _packageInfo.version,
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBackground(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.3),
      appBar: AppBar(
        title: Text(MessageProvider.of(context).actionAbout),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
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
            _getRelease(context),
            _getVersion(context),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(MessageProvider.of(context).informationsSupport),
            ),
            Hyperlink(
              url: krkadoniUrl,
              text: krkadoniUrl,
              fontSize: 20,
              color: Theme.of(context).accentColor.withOpacity(0.7),
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
                color: Theme.of(context).accentColor.withOpacity(0.7),
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
              color: Theme.of(context).accentColor.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }
}
