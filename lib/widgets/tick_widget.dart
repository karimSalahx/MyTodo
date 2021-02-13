import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_todo/models/note.dart';
import 'package:my_todo/services/database_service_provider.dart';
import 'package:provider/provider.dart';

class TickWidget extends StatelessWidget {
  final int index;
  final List<Note> list;
  final Color color;
  TickWidget({@required this.index, @required this.list, @required this.color});

  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<DatabaseServiceProvider>(context);

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => list[index].isFinished == 1
          ? databaseProvider.undoTask(list[index])
          : databaseProvider.finishTask(list[index]),
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
          child: Icon(
            FontAwesomeIcons.check,
            color: Colors.white,
            size: 15,
          ),
        ),
      ),
    );
  }
}
