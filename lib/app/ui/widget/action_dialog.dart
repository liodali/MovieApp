import 'package:flutter/material.dart';
import 'package:movie_app/app/ui/widget/loading_widget.dart';

class ActionDialog extends StatefulWidget {
  final Function() action;

  ActionDialog({Key? key, required this.action}) : super(key: key);

  @override
  _ActionDialogState createState() => _ActionDialogState();
}

class _ActionDialogState extends State<ActionDialog> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      widget.action();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 128,
        child: LoadingWidget(),
      ),
    );
  }
}
