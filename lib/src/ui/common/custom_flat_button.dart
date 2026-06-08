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
