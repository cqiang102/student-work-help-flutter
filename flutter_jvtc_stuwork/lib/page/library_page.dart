import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750.0;
    return Container(
//      decoration: BoxDecoration(color: Colors.purpleAccent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildButton(
              icon: CupertinoIcons.search,
              title: "查找图书",
              rpx: rpx,
              onPressed: () {}),
          Padding(padding: EdgeInsets.symmetric(vertical: 40 * rpx),),
          buildButton(
              icon: CupertinoIcons.flag,
              title: "登录系统",
              rpx: rpx,
              onPressed: () {}),
        ],
      ),
    );
  }

  buildButton(
      {IconData icon, String title, double rpx, VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5 * rpx),
          boxShadow: [
            BoxShadow(
              blurRadius: 4 * rpx,
              color: Colors.black38,
            )
          ]),
      margin: EdgeInsets.symmetric(horizontal: 30 * rpx),
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 20 * rpx, horizontal: 10 * rpx),
        color: Colors.grey[200],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.grey[800],
              size: 150 * rpx,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 80 * rpx,color: Colors.grey[800],),
            )
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
