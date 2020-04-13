import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jvtc_stuwork/model/app_data.dart';
import 'package:flutter_jvtc_stuwork/service/common_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageProvider with ChangeNotifier{
  final CommonService commonService = CommonService();
  AppData appData =  AppData();
  SharedPreferences prefs;
  VoidCallback initData;
  HomePageProvider(){

    initData = getData;
  }


  void getData() async{
    prefs = await SharedPreferences.getInstance();
    // 判断是否存在 data
    if(prefs.containsKey("appData")){
      int valKey = prefs.getInt("appData");
      print(valKey);
      // 计算相差时间
      int time = DateTime.now().millisecondsSinceEpoch - valKey;
      print("HomePageProvider logs (请求间隔) ->time $time 毫秒");
      int min = time~/(1000 * 60);
      print("HomePageProvider logs (请求间隔) ->time/(1000 * 60) $min 分");
      // 判断是否超时
      // 缓存60 分钟
      if(min<60){
        String jsonAppData = prefs.getString(valKey.toString());
        appData = AppData.fromJson(jsonDecode(jsonAppData));
        if(appData !=null){
          notifyListeners();
          return;
        }
      }
    }
    // 没有缓存，直接请求数据
    appData = await commonService.getAppData();
    notifyListeners();
  }
}
