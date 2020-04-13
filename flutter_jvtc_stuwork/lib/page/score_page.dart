import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jvtc_stuwork/model/score.dart';
import 'package:flutter_jvtc_stuwork/service/common_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ScorePage extends StatefulWidget {
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  SharedPreferences prefs;
  final CommonService commonService = CommonService();
  TextEditingController controller  = TextEditingController();
  bool ifLoading = false;

  @override
  void initState() {
    initSharedPreferences();

  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750.0;
  initPassword();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.chevron_left),
        ),
        title: Text("成绩单"),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned.fill(child: Container(
              padding:
              EdgeInsets.only(top: 200 * rpx, left: 60 * rpx, right: 60 * rpx),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 50 * rpx, vertical: 5 * rpx),
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10 * rpx)),
                    child: TextField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      controller: controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,

                        hintText: "请输入教务系统密码",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40 * rpx,
                  ),
                  FlatButton(
                    color: Colors.purple,
                    onPressed: () {
                      setState(() {
                        ifLoading = true;
                      });
                      Map map;
                      // 判断是否存在 workinfo

                      if (prefs.containsKey("scoreData")) {
                        int valKey = prefs.getInt("scoreData");
                        print(valKey);
                        // 计算相差时间
                        int time = DateTime.now().millisecondsSinceEpoch - valKey;
                        print("ScorePage logs (请求间隔) ->time $time 毫秒");
                        int min = time ~/ (1000 * 60);
                        print("ScorePage logs (请求间隔) ->time/(1000 * 60) $min 分");
                        // 判断是否超时
                        // 缓存60 分钟
                        if (min < 60) {
                          String json = prefs.getString(valKey.toString());
                          map = ScoreModel.jsonModelToModel(jsonDecode(json));
                          if (map != null) {
                            setState(() {
                              ifLoading = false;
                            });
                            prefs.setString("jw_pass",controller.text );
                            Navigator.of(context)
                                .pushNamed("scoreDetail", arguments: {"map": map});
                            return;
                          }
                        }
                      }
                      // 没有缓存，直接请求数据
                      Future<Map<String,List<ScoreModel>>> maps = commonService.scoreData(controller.text);
                      maps.then((value) {
                        setState(() {
                          ifLoading = false;
                        });
                        if (value == null||value.isEmpty) {
                          // 查询失败
                          Toast.show('查询失败', context,
                              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                          return;
                        } else {
                          prefs.setString("jw_pass",controller.text );
                          Navigator.of(context)
                              .pushNamed("scoreDetail", arguments: {"map": value});
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10 * rpx),
                      child: Center(
                        child: Text(
                          "查询",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      width: 500 * rpx,
                    ),
                  ),
                ],
              ),
            ),
            ),
            ifLoading?Positioned.fill(
              child: Container(
                color: Colors.transparent,
                child: SpinKitFadingCircle(
                  // 可以画一个圈，分为 0 1 2 3 4 5 6 7 8 9 份
                  itemBuilder: (_, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        // isEven 表示是否整数
                          color: index.isEven ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(10 * rpx)
                      ),
                    );
                  },
                  size: 80.0,
                ),
              ),
            )
                :Container(),
          ],
        ),
      ),
    );
  }

  void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void initPassword() async{
    if(prefs == null){
      prefs = await SharedPreferences.getInstance();
    }
    setState(() {
      controller.text = prefs.getString("jw_pass");
    });

  }
}
