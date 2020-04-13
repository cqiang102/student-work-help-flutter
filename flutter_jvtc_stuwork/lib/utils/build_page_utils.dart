import 'package:flutter/material.dart';

class BuildPageUtils {
  static Color fontColor = Colors.grey[700];
  static double fontSize = 35.0;

  static double iconSize = 40.0;

  static Widget wrapBuildItem(Widget left, Widget right, rpx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        left,
        right,
      ],
    );
  }

  static Widget buildItem(
      {@required IconData icon,
      @required String title,
      @required VoidCallback onPressed,
      @required double rpx}) {
    return Container(
      width: 250 * rpx,
      height: 110 * rpx,
      decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(3 * rpx),
          boxShadow: [
            BoxShadow(
              blurRadius: 4 * rpx,
              color: Colors.black54,
            )
          ]),
      child: FlatButton(
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: fontColor,
              size: iconSize * rpx,
            ),
            Text(
              title,
              style:
                  TextStyle(fontSize: (fontSize - 5) * rpx, color: fontColor),
            ),
          ],
        ),
      ),
    );
  }
}
