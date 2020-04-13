
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jvtc_stuwork/model/now_class.dart';
import 'package:flutter_jvtc_stuwork/service/common_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurriculumPageProvider  with ChangeNotifier{
  final CommonService commonService = CommonService();

  SharedPreferences prefs;
  Map map = Map();
  bool ifLoading = false;
  String week = "1";
  String totalWeek ="20";
  List<List<NowClass>> curriculum = <List<NowClass>>[
    <NowClass>[
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
    ],
    <NowClass>[
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
    ],
    <NowClass>[
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
    ],
    <NowClass>[
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
    ],
    <NowClass>[
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
    ],
    <NowClass>[
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
    ],
    <NowClass>[
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
    ],
    <NowClass>[
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
      NowClass(),
    ],
  ];



  CurriculumPageProvider(){
    initPrefs();

  }

  initPrefs()async {
    prefs =await SharedPreferences.getInstance();
  }
  initWeek()async{
    ifLoading = true;
    notifyListeners();
    // 查询缓存
    // 查询缓存
    if(prefs.containsKey("getWeek")){
      int valKey = prefs.getInt("getWeek");
      print(valKey);
      // 计算相差时间
      int time = DateTime.now().millisecondsSinceEpoch - valKey;
      print("CurriculumPageProvider logs (请求间隔) ->time $time 毫秒");
      int min = time~/(1000 * 60);
      print("CurriculumPageProvider logs (请求间隔) ->time/(1000 * 60) $min 分");
      // 判断是否超时
      // 缓存60 分钟
      if(min<60){
        String mapJson = prefs.getString(valKey.toString());
        map = jsonDecode(mapJson);
        if(map !=null&&map.containsKey("currentWeek")){
          week = map["currentWeek"];
          totalWeek = map["totalWeek"];
          notifyListeners();
          getCurriculum(week);
          return;
        }
      }
    }
    map = await commonService.getWeek();
    if(map.containsKey("currentWeek")){
      week = map["currentWeek"];
      totalWeek = map["totalWeek"];
      notifyListeners();
      getCurriculum(week);
      return;
    }
  }
  getCurriculum(String newWeek){
    String account = prefs.getString("account");
    // 查询缓存
    if(prefs.containsKey("curriculum-$newWeek-$account")){
      int valKey = prefs.getInt("curriculum-$newWeek-$account");
      print(valKey);
      // 计算相差时间
      int time = DateTime.now().millisecondsSinceEpoch - valKey;
      print("CurriculumPageProvider logs (请求间隔) ->time $time 毫秒");
      int min = time~/(1000 * 60);
      print("CurriculumPageProvider logs (请求间隔) ->time/(1000 * 60) $min 分");
      // 判断是否超时
      // 缓存60 分钟
      if(min<60){
        String curriculumJson = prefs.getString(valKey.toString());
        curriculum = NowClass.arrayJsonToArrayModel(jsonDecode(curriculumJson));
        if(curriculum !=null){
          notifyListeners();
          week = newWeek;
          ifLoading = false;
          return;
        }
      }
    }
    commonService.getCurriculum(account, newWeek).then((value){
      week = newWeek;
      curriculum = value;
      ifLoading = false;
      notifyListeners();
    });
  }
  nextWeek(bool flag){
    ifLoading = true;
    notifyListeners();
    String newWeek = week;
    if(flag){
      newWeek = "${int.parse(week)+1}";
      if(int.parse(newWeek)>=int.parse(totalWeek)){
        return;
      }
    }else{
      newWeek = "${int.parse(week)-1}";
      if(int.parse(newWeek)<=1){
        return;
      }
    }
    getCurriculum(newWeek);
  }


}
