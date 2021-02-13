import 'package:flutter/material.dart';
import 'package:my_todo/services/priority_service.dart';
import 'package:provider/provider.dart';

class PriorityContainerWidget extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color color;

  PriorityContainerWidget(
      {@required this.text, @required this.onTap, @required this.color});

  @override
  Widget build(BuildContext context) {
    int _counter = Provider.of<PriorityService>(context).counter;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: _counter == 0 ? Colors.grey[400] : color,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
