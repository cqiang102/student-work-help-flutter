import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jvtc_stuwork/model/app_data.dart';
import 'package:flutter_jvtc_stuwork/utils/build_page_utils.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  AppData appData = AppData();
  VoidCallback initData;


  @override
  _HomePageState createState() => _HomePageState();

  HomePage({this.appData, this.initData});
}

class _HomePageState extends State<HomePage> {
  Color fontColor = Colors.grey[700];
  double fontSize = 35.0;
  double iconSize = 35.0;
  static const String ICBC_BANK =
      "https://mywap2.icbc.com.cn/ICBCWAPBank/servlet/PortalInject?inject=paymentplatform_main%7CQ2hhcmdlaXRlbWNvZGU9UEoxMjAwMTIwMkIwMDAwMTgyOTc%3D";
  static const String JVTC_REPAIR = "http://sso.jvtc.jx.cn/cas/login";
  @override
  void initState() {
    widget.initData();
  }
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750.0;
    fontSize = 35.0 * rpx;
    iconSize = 50.0 * rpx;
    return Container(
        decoration: BoxDecoration(color: Colors.grey[100]),
        padding: EdgeInsets.only(top: 20 * rpx),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20 * rpx),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(
                      "当前应用数据",
                      style: TextStyle(fontSize: 40 * rpx, color: Colors.black),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        wrapBuildAppData(
                            buildAppData(
                                "总用户", "${widget.appData.toAllUserNum}", 32 * rpx, Colors.purple),
                            buildAppData(
                                "访问数", "${widget.appData.toMonthApisNum}", 32 * rpx, Colors.green)),
                        wrapBuildAppData(
                            buildAppData("今日新增", "${widget.appData.toDayNewUserNum}", 32 * rpx, Colors.blue),
                            buildAppData(
                                "今日访问", "${widget.appData.toDayApiNum}", 32 * rpx, Colors.orange)),
                      ],
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.all(15 * rpx),
              decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8 * rpx),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2 * rpx,
                      color: Colors.black54,
                    )
                  ]),
              height: 300 * rpx,
              width: 710 * rpx,
            ),
            Container(
              margin: EdgeInsets.only(top: 15 * rpx),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  BuildPageUtils.wrapBuildItem(
                      BuildPageUtils.buildItem(
                          icon: Icons.tab,
                          title: "课表",
                          rpx: rpx,
                          onPressed: () {

                            Navigator.of(context).pushNamed("curriculumPage");
//                            Toast.show('维护中', context,
//                                duration: Toast.LENGTH_LONG,
//                                gravity: Toast.CENTER);
                          }),
                      BuildPageUtils.buildItem(
                          icon: Icons.school,
                          title: "毕业生",
                          rpx: rpx,
                          onPressed: () {
                            Navigator.of(context).pushNamed("school");
                          }),
                      rpx),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20 * rpx),
                  ),
                  BuildPageUtils.wrapBuildItem(
                      BuildPageUtils.buildItem(
                          icon: Icons.error_outline,
                          title: "反馈帮助",
                          rpx: rpx,
                          onPressed: () {
                            Navigator.of(context).pushNamed("issues_help");
                          }),
                      BuildPageUtils.buildItem(
                          icon: Icons.score,
                          title: "成绩查询",
                          rpx: rpx,
                          onPressed: () {
                            Navigator.of(context).pushNamed("score");

                          }),
                      rpx),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20 * rpx),
                  ),
                  BuildPageUtils.wrapBuildItem(
                      BuildPageUtils.buildItem(
                          icon: Icons.credit_card,
                          title: "校园卡查看",
                          rpx: rpx,
                          onPressed: () {
                            Navigator.of(context).pushNamed("user_info");
                          }),
                      BuildPageUtils.buildItem(
                          icon: Icons.monetization_on,
                          title: "饭卡充值",
                          rpx: rpx,
                          onPressed: () {
                            _openIcbcBank();
                          }),
                      rpx),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20 * rpx),
                  ),
                  BuildPageUtils.buildItem(
                      icon: CupertinoIcons.settings,
                      title: "校园设备维修",
                      rpx: rpx,
                      onPressed: () {
                        _openJvtcRepair();
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

  buildAppData(String title, String num, double fontSize, Color dataColor) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: fontSize, color: fontColor),
        ),
        Text(
          num,
          style: TextStyle(
              fontSize: fontSize,
              color: dataColor,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  wrapBuildAppData(Widget left, Widget right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        left,
        right,
      ],
    );
  }

  _openIcbcBank() async {
    const url = ICBC_BANK;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _openJvtcRepair() async {
    const url = JVTC_REPAIR;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}
