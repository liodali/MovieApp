import 'package:flutter/material.dart';

class AppHero extends StatelessWidget {
  final String tag;
  final Widget child;

  const AppHero({
    Key? key,
    required this.tag,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        type: MaterialType.transparency,
        child: child,
      ),
    );
  }
}
