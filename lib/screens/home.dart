import 'package:animated_background/animated_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  // Bubbles
  final BubbleOptions _bubbleOptions = const BubbleOptions();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        behaviour: BubblesBehaviour(
          options: _bubbleOptions,
        ),
        vsync: this,
        child: Container(
          alignment: Alignment.center,
          child: const Text('Postal Share, a new way to share locations'),
        ),
      ),
    );
  }
}
