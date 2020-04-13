import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jvtc_stuwork/page/home_page.dart';
import 'package:flutter_jvtc_stuwork/page/index_drawer.dart';
import 'package:flutter_jvtc_stuwork/page/work_page.dart';
import 'package:flutter_jvtc_stuwork/provider/drawer_page_provider.dart';
import 'package:flutter_jvtc_stuwork/provider/home_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List<String> appBarTtile = <String>["应用中心", "学工平台相关", "图书馆"];
  int currentIndex = 0;
  List<Widget> bodys = <Widget>[
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomePageProvider(),
        )
      ],
      child: Consumer<HomePageProvider>(
        builder: (context, homePageProvider, _) {
          return HomePage(
            appData: homePageProvider.appData,
            initData: homePageProvider.initData,
          );
        },
      ),
    ),
    WorkPage(),
//    LibraryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    DateTime lastPopTime;
    double rpx = MediaQuery.of(context).size.width / 750.0;
    return WillPopScope(
        child: Scaffold(
          body: bodys[currentIndex],
          appBar: AppBar(
            backgroundColor: Colors.grey[400],
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: Icon(
                    CupertinoIcons.person,
                    color: Colors.black54,
                    size: 50 * rpx,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            title: Text(
              appBarTtile[currentIndex],
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  CupertinoIcons.forward,
                  color: Colors.black54,
                  size: 50 * rpx,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed("login", arguments: {"auto": false});
                },
              ),
            ],
          ),
          drawer: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
            child: Drawer(
              elevation: 10.0,
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => DrawerPageProvider(),
                  )
                ],
                child: Consumer<DrawerPageProvider>(
                  builder: (context, drawerPageProvider, _) {
                    return IndexDrawer(
                      account: drawerPageProvider.userAccount,
                      workInfo: drawerPageProvider.workInfo,
                      initData: drawerPageProvider.initData,
                      avatarUrl: drawerPageProvider.avatarUrl,
                      onTop: drawerPageProvider.onTap,
                    );
                  },
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.home,
                  size: 60 * rpx,
                ),
                title: Text("首页"),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.collections,
                  size: 60 * rpx,
                ),
                title: Text("学工平台"),
              ),
//              BottomNavigationBarItem(
//                icon: Icon(
//                  CupertinoIcons.bookmark,
//                  size: 60 * rpx,
//                ),
//                title: Text("图书馆"),
//              ),
            ],
          ),
        ),
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
        });
  }
}
