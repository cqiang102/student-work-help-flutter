import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_jvtc_stuwork/model/work_info.dart';



class IndexDrawer extends StatefulWidget {
  WorkInfo workInfo = WorkInfo();
  String avatarUrl = "images/chat1.jpg";
  String account = "";
  VoidCallback initData;
  VoidCallback onTop;

  @override
  _IndexDrawerState createState() => _IndexDrawerState();

  IndexDrawer({this.workInfo, this.account:"", this.initData,this.avatarUrl,this.onTop});
}

class _IndexDrawerState extends State<IndexDrawer> {


  @override
  void initState() {
    super.initState();
    widget.initData();
  }


  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750.0;
    TextStyle textStyle = TextStyle(fontSize: 30 * rpx);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.grey),
          height: 220 * rpx,
          padding: EdgeInsets.only(bottom: 30 * rpx),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(left: 40 * rpx, right: 30 * rpx),
                  width: 120 * rpx,
                  height: 120 * rpx,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(widget.avatarUrl),
                  ),
                ),
                onTap: () {
                  widget.onTop();
                },
              ),
              Text(
                widget.account,
                style: TextStyle(fontSize: 35 * rpx, color: Colors.white),
              ),
            ],
          ),
        ),
        Container(
          height: 650 * rpx,
          padding: EdgeInsets.only(left: 30 * rpx),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "旷课： ${widget.workInfo.truant == null ? 0 : widget.workInfo.truant}",
                style: textStyle,
              ),
              Text(
                "挂科： ${widget.workInfo.Failing == null ? 0 : widget.workInfo.Failing}",
                style: textStyle,
              ),
              Text(
                "违纪： ${widget.workInfo.Illegal == null ? 0 : widget.workInfo.Illegal}",
                style: textStyle,
              ),
              Text(
                "学分： ${widget.workInfo.score == null ? 0 : widget.workInfo.score}",
                style: textStyle,
              ),
              Text(
                "不及格： ${widget.workInfo.flunk == null ? 0 : widget.workInfo.flunk}",
                style: textStyle,
              ),
              Text(
                "平均成绩： ${widget.workInfo.grade == null ? 0 : widget.workInfo.grade}",
                style: textStyle,
              ),
              Text(
                "早操缺勤： ${widget.workInfo.absence == null ? 0 : widget.workInfo.absence}",
                style: textStyle,
              ),
              Text(
                "晚自习缺勤： ${widget.workInfo.study == null ? 0 : widget.workInfo.study}",
                style: textStyle,
              ),
            ],
          ),
        )
      ],
    );
  }
}
