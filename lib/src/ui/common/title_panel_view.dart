import 'package:flutter/material.dart';

class TitlePanelView extends StatelessWidget {
  final Widget child;

  const TitlePanelView({
    Key key,
    required this.child,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          const Radius.circular(10.0),
        ),
        color: theme.colorScheme.secondary.withOpacity(0.3),
        border: Border.all(color: theme.colorScheme.secondary.withOpacity(0.3)),
      ),
      child: child,
    );
  }
}
