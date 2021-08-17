import 'package:flutter/material.dart';

class MovieInformation extends StatelessWidget {
  final Widget icon;
  final String? information;
  final Widget? informationWidget;

  const MovieInformation({
    Key? key,
    required this.icon,
    this.information,
    this.informationWidget,
  })  : assert(information != null || informationWidget != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: 8,
          ),
          child: icon,
        ),
        if (information != null) ...[
          Text(information!),
        ] else if (informationWidget != null)
          informationWidget!,
      ],
    );
  }
}
