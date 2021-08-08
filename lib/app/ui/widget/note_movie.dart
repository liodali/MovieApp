import 'package:flutter/material.dart';

class NoteMovie extends StatelessWidget {
  final double note;
  final double? votes;

  const NoteMovie({
    Key? key,
    required this.note,
    this.votes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 3,horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 16,
                    color: Colors.amber,
                  ),
                  Text("$note",style: TextStyle(fontSize: 11),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
