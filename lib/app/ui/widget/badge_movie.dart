import 'package:flutter/material.dart';

class BadgeMovie extends StatelessWidget {
  final double elevation;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final OutlinedBorder? shape;
  final Widget? icon;
  final Widget title;

  const BadgeMovie({
    Key? key,
    this.elevation = 0.0,
    this.color,
    this.padding,
    this.shape,
    required this.title,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: shape,
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 5,
          ),
      labelPadding: EdgeInsets.zero,
      avatar: icon,
      label: title,
    );
  }
}
