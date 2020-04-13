import 'dart:async';

import 'package:flutter/material.dart';

/// 背景动画
class LoginProvider extends State<StatefulWidget> with ChangeNotifier,TickerProviderStateMixin {
  Animation<double> backgroundAnimation;
  AnimationController backgroundController;
  double opacityMain = 1.0;
  double opacityToChange = 0.0;
  int index = 0;
  int indexToChange = 1;
  List<String> imgList;
  Timer interval;
  LoginProvider(){
    imgList = <String>[
      "images/chat0.jpg",
      "images/chat1.jpg",
      "images/chat2.jpg",
      "images/chat3.jpg",
    ];

    backgroundController = AnimationController(vsync: this,duration: Duration(milliseconds: 3000));
    backgroundAnimation = Tween<double>(begin: 0.0,end: 1.0).animate(backgroundController)..addListener(() {
      opacityMain = 1.0-backgroundAnimation.value;
      opacityToChange = backgroundAnimation.value;
      notifyListeners();
    })..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        index++;
        indexToChange++;
        if(index == imgList.length){
          index = 0;
        }
        if(indexToChange == imgList.length){
          indexToChange = 0;
        }
        opacityMain = 1.0;
        opacityToChange = 0.0;
      }
    });
    interval = Timer.periodic(Duration(seconds: 8), (timer) {
      backgroundController.forward(from: 0);
    });
  }
  @override
  void dispose() {
    interval.cancel();
    backgroundController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

