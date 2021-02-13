import 'package:flutter/material.dart';
import 'package:my_todo/constants.dart';
import 'package:my_todo/models/note.dart';
import 'package:my_todo/services/database_service_provider.dart';
import 'package:my_todo/widgets/tick_widget.dart';
import 'package:provider/provider.dart';

class HomeListTileWidget extends StatelessWidget {
  final int index;
  final List<Note> list;
  HomeListTileWidget(this.index, this.list);

  String getMonth(String date) {
    int lastIndex = date.lastIndexOf('/');
    int i = int.parse(date.substring(0, lastIndex));
    String str = Constants.months[i - 1];
    return str + ' ' + date.substring(lastIndex + 1, date.length);
  }

  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<DatabaseServiceProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dismissible(
        key: ValueKey(list[index].id),
        direction: DismissDirection.endToStart,
        onDismissed: (dir) async {
          await databaseProvider.delete(list[index]);
        },
        background: Container(
          color: Theme.of(context).errorColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 34,
                ),
              ],
            ),
          ),
        ),
        child: InkWell(
          onTap: () => print('Edit'),
          child: Ink(
            child: Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListTile(
                  leading: AnimatedCrossFade(
                    crossFadeState: list[index].isFinished == 1
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 500),
                    firstChild: TickWidget(
                      index: index,
                      list: list,
                      color: Colors.grey[400],
                    ),
                    secondChild: TickWidget(
                      index: index,
                      list: list,
                      color: Colors.green[400],
                    ),
                  ),
                  title: Text(
                    '${list[index].title}',
                    style: TextStyle(
                      decoration: list[index].isFinished == 1
                          ? TextDecoration.lineThrough
                          : null,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Text(
                    getMonth(list[index].dateTime),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
