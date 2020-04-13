import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jvtc_stuwork/model/room_score.dart';

class RoomScorePage extends StatefulWidget {
  final VoidCallback initData;
  List<RoomScore> roomScores = <RoomScore>[
    RoomScore(),
    RoomScore(),
    RoomScore(),
    RoomScore(),

  ];

  @override
  _RoomScorePageState createState() => _RoomScorePageState();


  RoomScorePage({this.initData, this.roomScores});
}

class _RoomScorePageState extends State<RoomScorePage> {
  @override
  void initState() {
    widget.initData();
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750.0;
    TextStyle labelStyle = TextStyle(fontSize: 35 * rpx);
    TextStyle titleStyle =
    TextStyle(fontSize: 28 * rpx, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text("宿舍活动"),
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
              "images/chat2.jpg",
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
                  // 列表
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
                          "查寝列表",
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
                          height: widget.roomScores.length > 3
                              ? MediaQuery.of(context).size.height - (400 * rpx)
                              : widget.roomScores.length * 170 * rpx,
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
                            itemCount: widget.roomScores.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: Column(
                                  children: <Widget>[
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
                                                "宿舍：",
                                                style: titleStyle,
                                              ),
                                              Container(
                                                child: Text(
                                                    "${widget.roomScores[index].dorm}",
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis),
                                                width: 250 * rpx,
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
                                                "分数：",
                                                style: titleStyle,
                                              ),
                                              Text(
                                                  "${widget.roomScores[index].score}",
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
                                                "状态：",
                                                style: titleStyle,
                                              ),
                                              Container(
                                                child: Text(
                                                    "${widget.roomScores[index].grade}",
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
                                                "来源：",
                                                style: titleStyle,
                                              ),
                                              Text(
                                                  "${widget.roomScores[index].source}",
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
                                      MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Container(
                                          width: 380 * rpx,
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "时间：",
                                                style: titleStyle,
                                              ),
                                              Container(
                                                child: Text(
                                                    "${widget.roomScores[index].time}",
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis),
                                                width: 280 * rpx,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 250 * rpx,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                "周次：",
                                                style: titleStyle,
                                              ),
                                              Text(
                                                  "${widget.roomScores[index].week}",
                                                  maxLines: 1,
                                                  overflow:
                                                  TextOverflow.ellipsis),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
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
