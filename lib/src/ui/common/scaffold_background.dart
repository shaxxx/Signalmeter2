import 'package:flutter/material.dart';

import '../../constants.dart';

class ScaffoldBackground extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color backgroundColor;

  const ScaffoldBackground({
    super.key,
    required this.child,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundAsset),
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          appBar: appBar,
          floatingActionButton: floatingActionButton,
          backgroundColor: backgroundColor,
          bottomNavigationBar: bottomNavigationBar,
          body: child,
        ),
      ),
    );
  }
}
