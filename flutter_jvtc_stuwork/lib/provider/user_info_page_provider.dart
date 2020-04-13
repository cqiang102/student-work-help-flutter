import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jvtc_stuwork/model/user_info.dart';
import 'package:flutter_jvtc_stuwork/service/common_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoPageProvider with ChangeNotifier{
  final CommonService commonService = CommonService();
  UserInfo userInfo = UserInfo(basicsInfo: BasicsInfo(),contactInfo: ContactInfo(),homeInfo: HomeInfo(),schoolInfo: SchoolInfo());
  SharedPreferences prefs;
  VoidCallback initData;
  UserInfoPageProvider(){
    initData = getData;
  }
  void getData() async{
    prefs = await SharedPreferences.getInstance();
    // 判断是否存在 userInfo
    if(prefs.containsKey("userInfo")){
      int valKey = prefs.getInt("userInfo");
      print(valKey);
      // 计算相差时间
      int time = DateTime.now().millisecondsSinceEpoch - valKey;
      print("UserInfoPageProvider logs (请求间隔) ->time $time 毫秒");
      int min = time~/(1000 * 60);
      print("UserInfoPageProvider logs (请求间隔) ->time/(1000 * 60) $min 分");
      // 判断是否超时
      // 缓存60 分钟
      if(min<60){
        String jsonAppData = prefs.getString(valKey.toString());
        userInfo = UserInfo.fromJson(jsonDecode(jsonAppData));
        if(userInfo !=null){
          notifyListeners();
          return;
        }
      }
    }
    // 没有缓存，直接请求数据
    userInfo = await commonService.getUserInfo();
    notifyListeners();
  }

}
