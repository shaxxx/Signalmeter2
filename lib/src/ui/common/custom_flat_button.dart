import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const CustomFlatButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: child,
        ),
        //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
