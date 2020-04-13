
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jvtc_stuwork/model/quality_doing.dart';
import 'package:flutter_jvtc_stuwork/model/quality_score.dart';
import 'package:flutter_jvtc_stuwork/service/common_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QualityPageProvider with ChangeNotifier{
  final CommonService commonService = CommonService();
  SharedPreferences prefs;
  List<QualityDoing> qualityDoing = <QualityDoing>[];
  QualityScore qualityScore = QualityScore();
  VoidCallback getDoing;
  VoidCallback getScore;

  QualityPageProvider(){
    getDoing=_getDoingData;
    getScore=_getScoreData;
  }
  _getDoingData()async{
    prefs = await SharedPreferences.getInstance();
    // 判断是否存在 data
    if(prefs.containsKey("qualityDoing")){
      int valKey = prefs.getInt("qualityDoing");
      print(valKey);
      // 计算相差时间
      int time = DateTime.now().millisecondsSinceEpoch - valKey;
      print("QualityPageProvider qualityDoing logs (请求间隔) ->time $time 毫秒");
      int min = time~/(1000 * 60);
      print("QualityPageProvider qualityDoing logs (请求间隔) ->time/(1000 * 60) $min 分");
      // 判断是否超时
      // 缓存60 分钟
      if(min<60){
        String jsonAppData = prefs.getString(valKey.toString());
        qualityDoing = QualityDoing.jsonListToQualityScoreList(jsonDecode(jsonAppData));
        if(qualityDoing !=null){
          notifyListeners();
          return;
        }
      }
    }
    // 没有缓存，直接请求数据
    qualityDoing = await commonService.getQualityDoing();
    notifyListeners();
  }
  _getScoreData()async{
    prefs = await SharedPreferences.getInstance();
    // 判断是否存在 data
    if(prefs.containsKey("qualityScore")){
      int valKey = prefs.getInt("qualityScore");
      print(valKey);
      // 计算相差时间
      int time = DateTime.now().millisecondsSinceEpoch - valKey;
      print("QualityPageProvider qualityScore logs (请求间隔) ->time $time 毫秒");
      int min = time~/(1000 * 60);
      print("QualityPageProvider qualityScore logs (请求间隔) ->time/(1000 * 60) $min 分");
      // 判断是否超时
      // 缓存60 分钟
      if(min<60){
        String jsonAppData = prefs.getString(valKey.toString());
        qualityScore = QualityScore.fromJson(jsonDecode(jsonAppData));
        if(qualityScore !=null){
          notifyListeners();
          return;
        }
      }
    }
    // 没有缓存，直接请求数据
    qualityScore = await commonService.getQualityScore();
    notifyListeners();
  }

}
