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
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        //child: Icon(Icons.arrow_circle_down, size: 80.0,),
        child: MyBlinkingButton(),
        elevation: 0,
      ),
      backgroundColor: Colors.grey,
      body: AnimatedBackground(
        behaviour: BubblesBehaviour(
          options: _bubbleOptions,
        ),
        vsync: this,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.purple,
                  width: 2.0,
                ),
              ),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: const <TextSpan>[
                        TextSpan(text: 'Welcome to ', style: TextStyle(fontSize: 30, color: Colors.white)),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: const <TextSpan>[
                        TextSpan(text: 'Postal Share!', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: const <TextSpan>[
                        TextSpan(text: 'A new way of sharing locations', style: TextStyle(fontSize: 20, color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}

class MyBlinkingButton extends StatefulWidget {
  const MyBlinkingButton({Key key}) : super(key: key);

  @override
  _MyBlinkingButtonState createState() => _MyBlinkingButtonState();
}

class _MyBlinkingButtonState extends State<MyBlinkingButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
    AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: const Icon(Icons.arrow_downward_sharp, size: 80.0)
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
