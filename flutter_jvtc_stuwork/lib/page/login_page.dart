import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_jvtc_stuwork/page/login_box_page.dart';
import 'package:flutter_jvtc_stuwork/provider/login_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750.0;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => LoginProvider(),
              )
            ],
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                BackgroundSlideMain(),
                BackgroundSlideToChange(),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 220 * rpx,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 5  , sigmaX:  5 ),
              child: Opacity(
                child: LoginBox(),
                opacity: 0.9,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 1100 * rpx,
            child: Container(
              width: 750 * rpx - 2 * (60 * rpx),
              margin: EdgeInsets.symmetric(horizontal: 60 * rpx),
              child: Column(
                children: <Widget>[
                  Text(
                    "2018-2020 计算机技术协会",
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                  Text(
                    "QQ群:592874151",
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundSlideMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginProvider provider = Provider.of<LoginProvider>(context);
    return Opacity(
      opacity: provider.opacityMain,
      child: Image.asset(
        "images/chat${provider.index}.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}

class BackgroundSlideToChange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginProvider provider = Provider.of<LoginProvider>(context);
    return Opacity(
      opacity: provider.opacityToChange,
      child: Image.asset(
        "images/chat${provider.indexToChange}.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}
