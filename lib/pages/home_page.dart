import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_todo/models/note.dart';
import 'package:my_todo/services/database_service_provider.dart';
import 'package:my_todo/services/firebase_auth_helper.dart';
import 'package:my_todo/widgets/bottom_sheet_widget.dart';
import 'package:my_todo/widgets/home_listTile_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home-page';

  @override
  Widget build(BuildContext context) {
    final sqlProvider = Provider.of<DatabaseServiceProvider>(context);
    final authProvider = Provider.of<FirebaseAuthHelper>(context);
    int _counter = sqlProvider.finishedCounter;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.grey,
            ),
            onPressed: () => authProvider.signOut(context),
            tooltip: 'Log Out',
          )
        ],
        leading: Icon(
          Icons.menu,
          color: Colors.grey,
        ),
        title: Text(
          'My Todo',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[100],
      ),
      body: FutureBuilder<List<Note>>(
          future: sqlProvider.getAllData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              List<Note> _list = snapshot.data;

              return _list.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'What Todo?',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 36,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image.asset('assets/logo.jpg'),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Remaining Tasks ',
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                              Text(
                                '(${(_list.length - _counter).toString()})',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int i) =>
                                HomeListTileWidget(i, _list),
                            itemCount: _list.length,
                          ),
                        )
                      ],
                    );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          builder: (_) => BottomSheetWidget(),
        ),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }
}
