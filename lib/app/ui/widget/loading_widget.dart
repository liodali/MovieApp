import 'package:flutter/material.dart';
import '../../common/app_localization.dart';

class LoadingWidget extends StatelessWidget {
  final String? loadingText;

  LoadingWidget({
    Key? key,
    this.loadingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text(
            loadingText ?? MyAppLocalizations.of(context)!.loadingText,
          )
        ],
      ),
    );
  }
}
