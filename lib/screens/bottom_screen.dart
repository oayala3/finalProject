import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({Key key}) : super(key: key);

  @override
  _BottomScreenState createState() => _BottomScreenState();

}

class _BottomScreenState extends State<BottomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(100, 0, 100, 10),
        child: BottomAppBar(
          color: Colors.transparent,
          child: SizedBox(
            width: 10,
            height: 50,
            child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Exit App')),
          ),
          elevation: 0,
        ),
      ),
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Settings', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: TimerBuilder.periodic(const Duration(seconds: 1), builder: (context) {
                //print(getSystemTime());
                return Text(
                  getSystemTime(),
                  style: const TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.w700
                  ),
                );
              }),
            ),
          ],
        ),
      )
    );
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("H:m:s").format(now);
  }

}