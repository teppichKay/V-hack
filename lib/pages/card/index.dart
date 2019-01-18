import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'dummy_cards.dart';
import 'activeCard.dart';
import '../progress_bar.dart';
import '../shoes.dart';

class CardDemo extends StatefulWidget {
  @override 
  CardDemoState createState() => new CardDemoState();
}

class CardDemoState extends State<CardDemo> with TickerProviderStateMixin {
  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  int flag = 0;
  bool timeout = false;

  final List<List<String>> questions = [
    ['Do you prefer shoes that are slightly tighter or looser?', 'Tighter', 'Looser'], 
    ['Do you work out frequently?', 'No', 'Yes'],
    ['Do you prefer shoes that are slightly longer or shorter?', 'Longer', 'Shorter'],
    ['Do you run frequently?', 'No', 'Yes'], 
  ];

  void initState() {
    super.initState();

    _buttonController = new AnimationController(
      duration: new Duration(milliseconds: 1000),
      vsync: this,
    );

     rotate = new Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          questions.removeLast();
          _buttonController.reset();
        }
      });
    });

    right = new Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    bottom = new Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    width = new Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _swipeAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  startTimer(Duration milliseconds) {
    return new Timer(milliseconds, handleTimeout);
  }

  handleTimeout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShoesView()),
    );
  }

  dismissText(List text) {
   
    setState(() {
      questions.remove(text);
    });
  }

  addText(List text) {
    setState(() {
      questions.remove(text);
    });
  }

  swipeRight() {
    print(questions.length);
    if (questions.length == 1) {
      print('one card left');
      startTimer(const Duration(seconds: 3));
    }
    if (flag == 0)
      setState(() {
        flag = 1;
      });
    _swipeAnimation();
  }

  swipeLeft() {
    print(questions.length);
    if (questions.length == 1) {
      print('one card left');
      startTimer(const Duration(seconds: 3));
    }
    if (flag == 1)
      setState(() {
        flag = 0;
      });
    _swipeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;

    double initialBottom = 15.0;
    int dataLength = questions.length;
    double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
    double backCardWidth = -10.0;

    return (new Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Color.fromRGBO(28,36,75,1),
        title: Text('Questions', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 24.0)),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const BackButtonIcon(),
              onPressed: () {
                Navigator.pop(context);
              }
            );
          }
        )
      ),

      body: new Container(
        color: new Color.fromRGBO(0,0,0,0.1),
        alignment: Alignment.center,
        child: dataLength > 0
          ? new Stack(
              alignment: AlignmentDirectional.center,
              children: questions.map((item) {
                if (questions.indexOf(item) == dataLength - 1) {
                  return questionCardActive(
                    item,
                    bottom.value,
                    right.value,
                    0.0,
                    backCardWidth + 10,
                    rotate.value,
                    rotate.value < -10 ? 0.1 : 0.0,
                    context,
                    dismissText,
                    flag,
                    addText,
                    swipeRight,
                    swipeLeft
                  );
                } else {
                  backCardPosition = backCardPosition - 10;
                  backCardWidth = backCardWidth + 10;

                  return questionCardDummy(item, backCardPosition, 0.0, 0.0,
                      backCardWidth, 0.0, 0.0, context);
                }
              }).toList()
            )
          : new BarProgressIndicator(
              numberOfBars: 4,
              color: Color.fromRGBO(28,181,209, 1.0),
              fontSize: 10.0,
              barSpacing: 2.0,
              beginTweenValue: 40.0,
              endTweenValue: 80.0,
              milliseconds: 400,
            )
      ),
    ));
  }
}