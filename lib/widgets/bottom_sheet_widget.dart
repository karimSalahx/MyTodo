import 'package:flutter/material.dart';
import 'package:my_todo/models/note.dart';
import 'package:my_todo/services/database_service_provider.dart';
import 'package:my_todo/services/priority_service.dart';
import 'package:my_todo/widgets/priority_container_widget.dart';
import 'package:provider/provider.dart';

class BottomSheetWidget extends StatefulWidget {
  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _priorityProvider = Provider.of<PriorityService>(context);
    final _databaseProvider = Provider.of<DatabaseServiceProvider>(context);
    int _counter = _priorityProvider.counter;
    bool _isVisible = _priorityProvider.isVisible;
    double height = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Divider(
                color: Colors.black,
                thickness: 4,
                indent: 160,
                endIndent: 160,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Add a new Task',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: TextFormField(
                controller: _textController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'What To Do?',
                  labelText: 'ToDo',
                  labelStyle: TextStyle(letterSpacing: 1.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                validator: (String text) {
                  if (text.length > 20)
                    return 'You Have Exceeded maximum length!';
                  else if (text.length == 0)
                    return 'Please Provide any text!';
                  else
                    return null;
                },
                maxLength: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Priority',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              children: [
                PriorityContainerWidget(
                  text: 'High',
                  onTap: () => _priorityProvider.highPriority(),
                  color: _counter == 3 ? Colors.red[400] : Colors.grey[400],
                ),
                PriorityContainerWidget(
                  text: 'Normal',
                  onTap: () => _priorityProvider.normalPriority(),
                  color: _counter == 2 ? Colors.orange[400] : Colors.grey[400],
                ),
                PriorityContainerWidget(
                  text: 'Low',
                  onTap: () => _priorityProvider.lowPriority(),
                  color: _counter == 1 ? Colors.green[400] : Colors.grey[400],
                ),
              ],
            ),
            SizedBox(
              height: height * .08,
            ),
            Consumer<PriorityService>(
              builder: (_, __, ___) => Visibility(
                visible: !_isVisible,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '*Please Choose Priority',
                    style: TextStyle(
                      color: Theme.of(context).errorColor,
                      letterSpacing: 1.3,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      color: Colors.purple[400],
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          if (_counter > 0) {
                            var date = DateTime.now().toString();
                            var dataParse = DateTime.parse(date);
                            Note note = Note(
                              dateTime:
                                  '${dataParse.month}' '/' '${dataParse.day}',
                              priority: _counter,
                              title: _textController.text.trim(),
                              isFinished: 0,
                            );
                            await _databaseProvider.insert(note);

                            Navigator.of(context).pop();
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
