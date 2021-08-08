import 'package:flutter/material.dart';

class MovieInformation extends StatelessWidget {
  final Icon icon;
  final String information;

  const MovieInformation({
    Key? key,
    required this.icon,
    required this.information,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(right: 8),child: icon,),
        
        Text(information),
      ],
    );
  }
}
