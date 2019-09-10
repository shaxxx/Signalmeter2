import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomFlatButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const CustomFlatButton({
    Key key,
    @required this.child,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        child: Padding(
          child: child,
          padding: EdgeInsets.all(5),
        ),
        onTap: onPressed,
        //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
