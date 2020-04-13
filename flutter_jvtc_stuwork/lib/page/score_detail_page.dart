import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jvtc_stuwork/model/score.dart';

class ScoreDetailPage extends StatefulWidget {
   Map<String, List<ScoreModel>> scoreMaps = <String, List<ScoreModel>>{
    "2019-2020-1": <ScoreModel>[
      ScoreModel(),
    ],
    "2018-2019-2": <ScoreModel>[ScoreModel()],
    "2018-2019-1": <ScoreModel>[
      ScoreModel(),
    ],
  };

  @override
  _ScoreDetailPageState createState() => _ScoreDetailPageState();
}

class _ScoreDetailPageState extends State<ScoreDetailPage> {

  @override
  void didChangeDependencies() {
    Map obj = ModalRoute.of(context).settings.arguments;
    if (obj != null && obj.isNotEmpty) {
      widget.scoreMaps = obj["map"];
    }
  }
  @override
  Widget build(BuildContext context) {

    double rpx = MediaQuery.of(context).size.width / 750.0;
    List<Widget> listWeight = <Widget>[];
    widget.scoreMaps.forEach((key, value) {
      listWeight.add(buildItem(key, value, rpx));
    });
    listWeight = listWeight.reversed.toList();
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: listWeight,
          ),
        ),
      ),
    );
  }

  buildItem(String title, List<ScoreModel> list, double rpx) {
    List<Widget> listWeight = <Widget>[];
    list.forEach((element) {
      listWeight.add(Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                element.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(element.attr),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(element.score),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(element.stuScore),
            ),
          ),
        ],
      ));
    });
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20 * rpx,horizontal: 10 * rpx),
      margin: EdgeInsets.symmetric(vertical: 20 * rpx, horizontal: 10 * rpx),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10 * rpx),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10 * rpx)]),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffeaeaea),width: 1 * rpx,style: BorderStyle.solid))),
            padding: EdgeInsets.all(10 * rpx),
            margin: EdgeInsets.all(10 * rpx),
            child: Center(
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600,fontSize: 30 * rpx),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: Text("课程名称",style: TextStyle(fontWeight: FontWeight.w600),),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text("课程属性",style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text("成绩",style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text("学分",style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
          Column(
            children: listWeight,
          ),
        ],
      ),
    );
  }
}
