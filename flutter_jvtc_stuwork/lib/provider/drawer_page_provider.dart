import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jvtc_stuwork/model/work_info.dart';
import 'package:flutter_jvtc_stuwork/service/common_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPageProvider  with ChangeNotifier{
  final CommonService commonService = CommonService();

  SharedPreferences prefs;
  WorkInfo workInfo = WorkInfo();
  String userAccount = "";
  String avatarUrl = "images/chat1.jpg";
  VoidCallback initData;
  VoidCallback onTap;

  DrawerPageProvider(){

    initData = getData;
    onTap = getAvatarUrl;
  }

  getAvatarUrl(){
    avatarUrl  = "images/chat3.jpg";
    notifyListeners();
  }
  getData () async {
    prefs = await SharedPreferences.getInstance();
    userAccount = prefs.getString("account");
    // 判断是否存在 workinfo
    if(prefs.containsKey("workinfo")){
      int valKey = prefs.getInt("workinfo");
      print(valKey);
      // 计算相差时间
      int time = DateTime.now().millisecondsSinceEpoch - valKey;
      print("DrawerPageProvider logs (请求间隔) ->time $time 毫秒");
      int min = time~/(1000 * 60);
      print("DrawerPageProvider logs (请求间隔) ->time/(1000 * 60) $min 分");
      // 判断是否超时
      // 缓存60 分钟
      if(min<60){
        String jsonWorkInfo = prefs.getString(valKey.toString());
        workInfo = WorkInfo.fromJson(jsonDecode(jsonWorkInfo));
        if(workInfo !=null){
          notifyListeners();
          return;
        }
      }
    }
  // 没有缓存，直接请求数据
    workInfo = await commonService.getWorkInfo();
    notifyListeners();
  }


}
