import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jvtc_stuwork/service/common_service.dart';
import 'package:flutter_jvtc_stuwork/utils/string_utils.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class IssuesHelp extends StatefulWidget {
  @override
  _IssuesHelpState createState() => _IssuesHelpState();
}

class _IssuesHelpState extends State<IssuesHelp> {
   static  const  String BU_CAI_URL = "https://blog.ncgame.cc/";
   static  const  String MU_LIANG_URL = "https://blog.cccccc.online/";
   TextEditingController editingController = TextEditingController();
   final CommonService commonService = CommonService();
   bool ifButton = true;
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text("关于与帮助"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 230 * rpx,
//              child: Text("head"),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10 * rpx),
                      height: 130 * rpx,
                      width: 280 * rpx,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10 * rpx),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1 * rpx,
                            color: Colors.black54,
                          )
                        ],
                        color: Colors.white,
                      ),
                      child: FlatButton(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.alternate_email,
                              size: 60 * rpx,
                            ),
                            Text(
                              "不才的博客",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        onPressed: () {
                          _openBuCaiBrower();
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10 * rpx),
                      height: 130 * rpx,
                      width: 280 * rpx,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10 * rpx),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1 * rpx,
                            color: Colors.black54,
                          )
                        ],
                        color: Colors.white,
                      ),
                      child: FlatButton(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.alternate_email,
                              size: 60 * rpx,
                            ),
                            Text(
                              "沐凉的博客",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        onPressed: () {
                          _openMuLiangBrower();
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
//              height: 600 * rpx,
                padding: EdgeInsets.symmetric(
                    horizontal: 20 * rpx, vertical: 2 * rpx),
                child: Container(
                  width: (750 * rpx) - (20 * rpx),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2 * rpx,
                          color: Colors.black54,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10 * rpx)),
                  child: Container(
                    padding: EdgeInsets.all(22 * rpx),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "开发说明",
                          style: TextStyle(
                              fontSize: 28 * rpx, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "首先感谢\n" +
                              "感谢信工-计算机技术协会帮助测试\n" +
                              "感谢信工-计算机技术协会提供维修平台\n" +
                              "感谢信工-计算机技术协会提供学工网相关接口\n" +
                              "开发概述\n" +
                              "目前由我[不才]负责 app 开发、负责相关接口\n" +
                              "由信工-计算机技术协会测试\n" +
                              "如果在使用中遇到问题或者对平台技术感兴趣可提意见或加群",
                          style: TextStyle(fontSize: 27 * rpx),
                        ),
                        GestureDetector(
                          onLongPressStart: (details) {
                            Clipboard.setData(ClipboardData(text: '592874151'));
                            Toast.show("复制成功", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.CENTER);
                          },
                          child: Text(
                            "Q群号(长按复制)：592874151\n",
                            style: TextStyle(fontSize: 27 * rpx),
                          ),
                        ),
                        TextField(
                          maxLines: 4,
                          controller: editingController,
                          decoration: InputDecoration(
                            labelText: "问题反馈",
                            labelStyle: TextStyle(color: Colors.deepOrange),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange, width: 3 * rpx)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange, width: 3 * rpx)),
                            hintText: "请输入问题详情，如果可以的话麻烦留联系方式谢谢",
                          ),
                        ),
                        Container(
                          height: 70 * rpx,
                          margin: EdgeInsets.symmetric(
                              horizontal: (((750 * rpx) - (620 * rpx)) / 2),
                              vertical: 20 * rpx),
                          width: 620 * rpx,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4 * rpx,
                                color: Colors.black54,
                              )
                            ],
                            color: Colors.orangeAccent,
                          ),
                          child: FlatButton(
                            color: Colors.orangeAccent,
                            child: Text(
                              "提交",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: ifButton?() {
                              if(StringUtils.isNull(editingController.text)){
                                Toast.show('提交不能为空~', context,
                                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                              }else{
                                setState(() {
                                  ifButton = false;
                                });
                                commonService.putIssues(editingController.text).then((value) {
                                setState(() {
                                  ifButton = true;
                                });
                                Toast.show(value?'提交成功':'提交失败', context,
                                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                              });
                              }
                            }:null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(color: Colors.grey[100]),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _openBuCaiBrower() async {
    const url = BU_CAI_URL;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
   _openMuLiangBrower() async {
     const url = MU_LIANG_URL;
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }
}
