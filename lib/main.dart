import "dart:io";
import "package:flutter/material.dart";
import 'avatar.dart';
import "postals/postals.dart";
import "utils.dart" as utils;
import 'package:path_provider/path_provider.dart';


void main() async {
  startMeUp() async {
    WidgetsFlutterBinding.ensureInitialized();
    Avatar.docsDir = await getApplicationDocumentsDirectory();
    runApp(FlutterBook());
  }
  startMeUp();
}


class _Dummy extends StatelessWidget {
  final _title;

  _Dummy(this._title);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(_title));
  }
}

class FlutterBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: DefaultTabController(
            length: 1,
            child: Scaffold(
                appBar: AppBar(
                    title: Text('Oscar Ayala FlutterBook'),
                    bottom: TabBar(
                        tabs: [
                          Tab(icon: Icon(Icons.assignment_turned_in), text: 'Postals'),
                        ]
                    )
                ),
                body: TabBarView(
                    children: [
                      Postals(),
                    ]
                )
            )
        )
    ); }  }


