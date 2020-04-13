import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jvtc_stuwork/model/quality_doing.dart';
import 'package:flutter_jvtc_stuwork/model/quality_score.dart';
import 'package:flutter_jvtc_stuwork/service/common_service.dart';
import 'package:toast/toast.dart';

class QualityDoingPage extends StatefulWidget {
  final CommonService commonService = CommonService();
  VoidCallback getScore;
  VoidCallback getDoing;
  QualityScore qualityScore = QualityScore();
  List<QualityDoing> qualityDoings = <QualityDoing>[
    QualityDoing(stat: "活动认证中"),
    QualityDoing(stat: "已经评价"),
    QualityDoing(stat: "活动认证中"),
    QualityDoing(stat: "已经评价"),

//    QualityDoing(),
  ];

  @override
  _QualityDoingPageState createState() => _QualityDoingPageState();

  QualityDoingPage(
      {this.getScore, this.getDoing, this.qualityScore, this.qualityDoings});
}

class _QualityDoingPageState extends State<QualityDoingPage> {
  @override
  void initState() {
    widget.getScore();
    widget.getDoing();
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750.0;
    TextStyle labelStyle = TextStyle(fontSize: 35 * rpx);
    TextStyle titleStyle =
        TextStyle(fontSize: 26 * rpx, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text("素拓活动"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Image.asset(
              "images/chat1.jpg",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(top: 20 * rpx),
              padding: EdgeInsets.symmetric(
                  vertical: 10 * rpx, horizontal: 20 * rpx),
              child: Column(
                children: <Widget>[
                  // 素拓分各类得分
                  Container(
                    margin: EdgeInsets.only(bottom: 20 * rpx),
                    padding: EdgeInsets.symmetric(
                        horizontal: 25 * rpx, vertical: 20 * rpx),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10 * rpx),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1 * rpx,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "素拓分各类得分",
                          style: labelStyle,
                        ),
                        // 横线
                        Container(
                          width: double.infinity,
                          height: 1.0,
                          color: Colors.grey[400],
                          margin: EdgeInsets.symmetric(
                              horizontal: 5 * rpx, vertical: 15 * rpx),
                        ),
                        Center(
                          child: Container(
                            child: Wrap(
                              runSpacing: 15 * rpx,
                              spacing: 85 * rpx,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runAlignment: WrapAlignment.spaceEvenly,
                              alignment: WrapAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  width: 160 * rpx,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "A类：",
                                        style: titleStyle,
                                      ),
                                      Text("${widget.qualityScore.CountA1}"),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 160 * rpx,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "B类：",
                                        style: titleStyle,
                                      ),
                                      Text("${widget.qualityScore.CountB1}"),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 160 * rpx,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "C类：",
                                        style: titleStyle,
                                      ),
                                      Text("${widget.qualityScore.CountC1}"),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 160 * rpx,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "D类：",
                                        style: titleStyle,
                                      ),
                                      Text("${widget.qualityScore.CountD1}"),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 160 * rpx,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "E类：",
                                        style: titleStyle,
                                      ),
                                      Text("${widget.qualityScore.CountE1}"),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 160 * rpx,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "F类：",
                                        style: titleStyle,
                                      ),
                                      Text("${widget.qualityScore.CountF1}"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10 * rpx,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 200 * rpx,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "总分：",
                                    style: titleStyle,
                                  ),
                                  Text("${widget.qualityScore.SunCount1}"),
                                ],
                              ),
                            ),
                            Container(
                              width: 200 * rpx,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "总结：",
                                    style: titleStyle,
                                  ),
                                  Text("${widget.qualityScore.Status}"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  // 素拓活动列表
                  Container(
                    margin: EdgeInsets.only(bottom: 30 * rpx),
                    padding: EdgeInsets.symmetric(
                        horizontal: 25 * rpx, vertical: 20 * rpx),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10 * rpx),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1 * rpx,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "素拓活动列表",
                          style: labelStyle,
                        ),
                        Container(
                          width: double.infinity,
                          height: 1.0,
                          color: Colors.grey[400],
                          margin: EdgeInsets.symmetric(
                              horizontal: 5 * rpx, vertical: 15 * rpx),
                        ),
                        Container(
                          height: widget.qualityDoings.length > 3
                              ? MediaQuery.of(context).size.height - (600.0 * rpx)- (80.0 * rpx)
                              : widget.qualityDoings.length * 170 * rpx,
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10 * rpx),
                                  child: Divider(
                                    height: 2.0,
                                    color: Colors.grey,
                                  ));
                            },
                            shrinkWrap: true,
                            itemCount: widget.qualityDoings.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: (){
                                  QualityDoing item = widget.qualityDoings[index];
                                  print("logs ListView onTop ${item}");
                                  if(item.stat == ""){
                                    Future<bool> status = widget.commonService.appAction(widget.qualityDoings[index].id);
                                    status.then((value){
                                      Toast.show(value?"评价成功":"评价失败", context,
                                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                    });
                                  }

                                },
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "${widget.qualityDoings[index].name}",
                                        maxLines: 1,
                                        style: titleStyle,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            width: 350 * rpx,
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  "主办方：",
                                                  style: titleStyle,
                                                ),
                                                Container(
                                                  child: Text(
                                                      "${widget.qualityDoings[index].unit}",
                                                      maxLines: 1,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  width: 200 * rpx,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 300 * rpx,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  "时间：",
                                                  style: titleStyle,
                                                ),
                                                Text(
                                                    "${widget.qualityDoings[index].date}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            width: 350 * rpx,
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  "活动类型：",
                                                  style: titleStyle,
                                                ),
                                                Container(
                                                  child: Text(
                                                      "${widget.qualityDoings[index].type}",
                                                      maxLines: 1,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  width: 200 * rpx,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 300 * rpx,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  "分值：",
                                                  style: titleStyle,
                                                ),
                                                Text(
                                                    "${widget.qualityDoings[index].score}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("状态："),
                                          Text(
                                            "${widget.qualityDoings[index].stat}",
                                            style: widget.qualityDoings[index]
                                                        .stat ==
                                                    "已经评价"
                                                ? TextStyle()
                                                : TextStyle(color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 家庭信息
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
