import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  final Widget child;
  // Nullable: a null callback renders the button disabled (InkWell.onTap null),
  // matching the original pre-null-safety behavior. Required-non-null forced
  // call sites to use `!`, which crashed in transient states (e.g. connecting,
  // where the connect button is shown but its callback is null).
  final VoidCallback? onPressed;

  const CustomFlatButton({
    super.key,
    required this.child,
    this.onPressed,
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
