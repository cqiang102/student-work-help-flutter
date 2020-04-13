import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jvtc_stuwork/component/my_app_bar.dart';
import 'package:flutter_jvtc_stuwork/model/now_class.dart';
import 'package:flutter_jvtc_stuwork/provider/curriculum_page_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CurriculumPage extends StatefulWidget {
  CurriculumPageProvider curriculumProvider;

  CurriculumPage({this.curriculumProvider});

  @override
  _CurriculumPageState createState() => _CurriculumPageState();
}

class _CurriculumPageState extends State<CurriculumPage> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      widget.curriculumProvider.initWeek();
    });
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750.0;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // 修改了 _kLeadingWidth 的 AppBar
      appBar: MyAppBar(
        backgroundColor: Colors.grey[400],
        centerTitle: true,
        leading: FlatButton(
          onPressed: () {
            widget.curriculumProvider.nextWeek(false);
          },
          child: Container(
            child: Text("上一周",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 32 * rpx)),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              widget.curriculumProvider.nextWeek(true);
            },
            child: Text(
              "下一周",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 32 * rpx),
            ),
          ),
        ],
        title: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("第${widget.curriculumProvider.week}周",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                    "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}"),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color(
                            0xfffafafa,
                          ),
                          width: 1,
                          style: BorderStyle.solid)),
                  color: Colors.grey.withOpacity(0.2),
                ),
                height: 50 * rpx,
                width: 750 * rpx,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Center(
                          child: Text("${DateTime.now().month}月"),
                        ),
                      ),
                    ),
                    buildTableTitle("周日", 7),
                    buildTableTitle("周一", 1),
                    buildTableTitle("周二", 2),
                    buildTableTitle("周三", 3),
                    buildTableTitle("周四", 4),
                    buildTableTitle("周五", 5),
                    buildTableTitle("周六", 6),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 50 * rpx,
              child: Container(
//                decoration: BoxDecoration(color: Colors.orangeAccent),
                width: 750 * rpx,
                height: height - (50 * rpx),
                child: Column(
                  children: <Widget>[
                    // 课表第一行
                    Container(
                      height: (height - (225 * rpx)) / 6,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(
                                    0xfffafafa,
                                  ),
                                  width: 1,
                                  style: BorderStyle.solid))),
                      child: Row(
                        children: buildClassList(rpx, 0),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(
                                    0xfffafafa,
                                  ),
                                  width: 1,
                                  style: BorderStyle.solid))),
                      height: (height - (225 * rpx)) / 6,
                      child: Row(
                        children: buildClassList(rpx, 1),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(
                                    0xfffafafa,
                                  ),
                                  width: 1,
                                  style: BorderStyle.solid))),
                      height: (height - (225 * rpx)) / 6,
                      child: Row(
                        children: buildClassList(rpx, 2),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(
                                    0xfffafafa,
                                  ),
                                  width: 1,
                                  style: BorderStyle.solid))),
                      height: (height - (225 * rpx)) / 6,
                      child: Row(
                        children: buildClassList(rpx, 3),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(
                                    0xfffafafa,
                                  ),
                                  width: 1,
                                  style: BorderStyle.solid))),
                      height: (height - (225 * rpx)) / 6,
                      child: Row(
                        children: buildClassList(rpx, 4),
                      ),
                    ),
                    Container(
                      height: (height - (225 * rpx)) / 6,
                      child: Row(
                        children: buildClassList(rpx, 5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            widget.curriculumProvider.ifLoading
                ? Positioned.fill(
                    child: Container(
                      color: Colors.transparent,
                      child: SpinKitFadingCircle(
                        // 可以画一个圈，分为 0 1 2 3 4 5 6 7 8 9 份
                        itemBuilder: (_, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                                // isEven 表示是否整数
                                color: index.isEven
                                    ? Colors.redAccent
                                    : Colors.greenAccent,
                                borderRadius: BorderRadius.circular(10 * rpx)),
                          );
                        },
                        size: 80.0,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  buildClassList(double rpx, int y) {
    return <Widget>[
      Expanded(
        flex: 1,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "${y + 1}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("(${2 * (y +1) - 1},${2 * (y +1)}小节)",
                    style: TextStyle(fontSize: 25 * rpx)),
              ],
            ),
          ),
          decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
        ),
      ),
      buildClass(rpx, 0, y),
      buildClass(rpx, 1, y),
      buildClass(rpx, 2, y),
      buildClass(rpx, 3, y),
      buildClass(rpx, 4, y),
      buildClass(rpx, 5, y),
      buildClass(rpx, 6, y),
    ];
  }

  buildClass(double rpx, int x, int y) {
    NowClass temp = widget.curriculumProvider.curriculum[x][y];
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          if (temp.name == "" && temp.teacher == "") {
            return;
          } else {
            showDialog(
                context: context,
                child: AlertDialog(
                  title: Container(
                    padding: EdgeInsets.only(bottom: 20 * rpx),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.black38,
                                width: 2 * rpx,
                                style: BorderStyle.solid))),
                    child: Text(
                      "详请",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  content: Container(
                    width: 600 * rpx,
                    height: 450 * rpx,
                    child: Column(
                      children: <Widget>[
                        Text(temp.name),
                        Text(temp.teacher),
                        Text(temp.aClass),
                        Text(temp.time),
                        Text(temp.address),
                        Text(temp.addressDetail),
                        Text(temp.status),
                        Text(temp.type),
                        Text(temp.allTime),
                      ],
                    ),
                  ),
                ));
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: temp.name == "" && temp.addressDetail == ""
                  ? Colors.transparent
                  : Colors.grey.withOpacity(0.6)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  temp.name,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  temp.addressDetail,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildTableTitle(String s, int i) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
            color: DateTime.now().weekday == i
                ? Colors.blue.withOpacity(0.3)
                : Colors.transparent),
        child: Center(
          child: Text(s),
        ),
      ),
    );
  }
}
