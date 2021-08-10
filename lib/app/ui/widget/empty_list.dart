import 'package:flutter/material.dart';
import 'package:movie_app/app/common/app_localization.dart';

class EmptyList extends StatelessWidget {
  final String? messageEmptyList;
  final Icon? iconEmptyList;

  const EmptyList({
    Key? key,
    this.messageEmptyList,
    this.iconEmptyList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          iconEmptyList ??
              Icon(
                Icons.movie_outlined,
                color: Colors.grey[400],
                size: 32,
              ),
          Text(
            messageEmptyList ?? MyAppLocalizations.of(context)!.emptyList,
          )
        ],
      ),
    );
  }
}
