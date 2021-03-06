import 'package:flutter/material.dart';
import 'package:movie_app/app/common/app_localization.dart';

class NoteMovie extends StatelessWidget {
  final double note;
  final int? votes;
  final double elevation;

  const NoteMovie({
    Key? key,
    required this.note,
    this.votes,
    this.elevation = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            elevation: elevation,
            color: Theme.of(context).dividerColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 3,
                horizontal: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 16,
                    color: Colors.amber,
                  ),
                  Text(
                    "$note",
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
          if (votes != null) ...[
            Text(
              "($votes ${MyAppLocalizations.of(context)!.votes})",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            )
          ]
        ],
      ),
    );
  }
}
