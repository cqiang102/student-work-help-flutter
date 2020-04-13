import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jvtc_stuwork/page/curriculum_page.dart';
import 'package:flutter_jvtc_stuwork/page/index_page.dart';
import 'package:flutter_jvtc_stuwork/page/issues_help_page.dart';
import 'package:flutter_jvtc_stuwork/page/quality_doing_page.dart';
import 'package:flutter_jvtc_stuwork/page/room_score_page.dart';
import 'package:flutter_jvtc_stuwork/page/score_detail_page.dart';
import 'package:flutter_jvtc_stuwork/page/score_page.dart';
import 'package:flutter_jvtc_stuwork/page/user_info_page.dart';
import 'package:flutter_jvtc_stuwork/provider/curriculum_page_provider.dart';
import 'package:flutter_jvtc_stuwork/provider/quality_page_provider.dart';
import 'package:flutter_jvtc_stuwork/provider/room_score_page_provider.dart';
import 'package:flutter_jvtc_stuwork/provider/user_info_page_provider.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'page/login_page.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  static const String SCHOOL_URL = "https://seniors.netlify.com/";

  @override
  Widget build(BuildContext context) {
    DateTime lastPopTime;
    return MaterialApp(
      routes: {
        "main": (BuildContext context) => IndexPage(),
        "score": (BuildContext context) => ScorePage(),
        "scoreDetail": (BuildContext context) => ScoreDetailPage(),
        "curriculumPage": (BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => CurriculumPageProvider(),
            )
          ],
          child: Consumer<CurriculumPageProvider>(
            builder: (context, curriculumPageProvider, _) {
              return CurriculumPage(
                curriculumProvider: curriculumPageProvider,
              );
            },
          ),
        ),
        "quality": (BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => QualityPageProvider(),
            )
          ],
          child: Consumer<QualityPageProvider>(
            builder: (context, qualityPageProvider, _) {
              return QualityDoingPage(
                qualityScore: qualityPageProvider.qualityScore,
                qualityDoings: qualityPageProvider.qualityDoing,
                getDoing: qualityPageProvider.getDoing,
                getScore: qualityPageProvider.getScore,
              );
            },
          ),
        ),
        "roomScore": (BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => RoomScorePageProvider(),
            )
          ],
          child: Consumer<RoomScorePageProvider>(
            builder: (context, roomScorePageProvider, _) {
              return RoomScorePage(
                roomScores: roomScorePageProvider.roomScores,
                initData: roomScorePageProvider.getRoomScore,
              );
            },
          ),
        ),
        "login": (BuildContext context) => LoginPage(),
        "school":(BuildContext context) =>WebviewScaffold(
          url: SCHOOL_URL,
          appBar: AppBar(
            title: Text("九职-毕业生"),
            backgroundColor: Colors.lightBlue,
            leading: IconButton(
              icon: Icon(Icons.home),
              onPressed: (){
                Navigator.of(context).pushReplacementNamed("main");
              },
            ),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.remove_red_eye),onPressed: (){
                _openBrower();
              },),
            ],
          ),
        ),
        "issues_help":(BuildContext context)=>IssuesHelp(),
        "user_info":(BuildContext context)=>    MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => UserInfoPageProvider(),
            )
          ],
          child: Consumer<UserInfoPageProvider>(
            builder: (context, userInfoPageProvider, _) {
              return UserInfoPage(
                userInfo: userInfoPageProvider.userInfo,
                initData: userInfoPageProvider.initData,
              );
            },
          ),
        ),
      },
      title: '九江职业技术学院-学工网',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: WillPopScope(
          child: SafeArea(child: LoginPage(),),
          onWillPop: () async {
            if (lastPopTime == null ||
                DateTime.now().difference(lastPopTime) > Duration(seconds: 1)) {
              lastPopTime = DateTime.now();
              Toast.show('再按一次退出', context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            } else {
              lastPopTime = DateTime.now();
              // 退出app
              await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }
          }),
    );
  }
  _openBrower() async {
    const url = SCHOOL_URL;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
