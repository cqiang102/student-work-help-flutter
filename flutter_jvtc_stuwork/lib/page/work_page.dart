import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jvtc_stuwork/utils/build_page_utils.dart';

class WorkPage extends StatefulWidget {
  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750.0;
    return Container(
        padding: EdgeInsets.only(top: 30 * rpx),
        decoration: BoxDecoration(color: Colors.grey[100]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15 * rpx),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  BuildPageUtils.wrapBuildItem(
                      BuildPageUtils.buildItem(
                          icon: Icons.list,
                          title: "素拓活动",
                          rpx: rpx,
                          onPressed: () {
                            Navigator.of(context).pushNamed("quality");
                          }),
                      BuildPageUtils.buildItem(
                          icon: Icons.room_service,
                          title: "查寝情况",
                          rpx: rpx,
                          onPressed: () {
                            Navigator.of(context).pushNamed("roomScore");
                          }),
                      rpx),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20 * rpx),
                  ),
                  BuildPageUtils.buildItem(
                      icon: Icons.face,
                      title: "个人详细信息",
                      rpx: rpx,
                      onPressed: () {
                        Navigator.of(context).pushNamed("user_info");
                      }),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20 * rpx),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
