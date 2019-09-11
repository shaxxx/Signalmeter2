import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TitlePanelView extends StatelessWidget {
  final Widget child;

  const TitlePanelView({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(
          const Radius.circular(10.0),
        ),
        color: theme.accentColor.withOpacity(0.3),
        border: Border.all(color: theme.accentColor.withOpacity(0.3)),
      ),
      child: child,
    );
  }
}
