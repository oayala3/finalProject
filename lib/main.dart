import "dart:io";
import "package:flutter/material.dart";
import 'package:untitled/screens/bottom_screen.dart';
import 'package:untitled/screens/home.dart';
import 'avatar.dart';
import "postals/postals.dart";
import "utils.dart" as utils;
import 'package:path_provider/path_provider.dart';

void main() async {
  startMeUp() async {
    WidgetsFlutterBinding.ensureInitialized();
    Avatar.docsDir = await getApplicationDocumentsDirectory();
    runApp(const MyApp());
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
        theme: ThemeData(primarySwatch: Colors.grey),
        home: DefaultTabController(
            length: 1,
            child: Scaffold(
                appBar: AppBar(
                    title: Text('Postal Share'),
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


class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return PageView(
      scrollDirection: Axis.vertical,
      controller: controller,
      children: <Widget>[
        const Center(
          child: MyHomePage(title: 'Home page'),
        ),
        Center(
          child: FlutterBook(),
        ),
        const Center(
          child: BottomScreen(),
        )
      ],
    );
  }
}




