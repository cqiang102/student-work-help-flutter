import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_jvtc_stuwork/model/room_score.dart';
import 'package:flutter_jvtc_stuwork/service/common_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomScorePageProvider with ChangeNotifier {
  final CommonService commonService = CommonService();
  SharedPreferences prefs;
  List<RoomScore> roomScores = <RoomScore>[];
  VoidCallback getRoomScore;

  RoomScorePageProvider() {
    getRoomScore = _getRoomScore;
  }

  _getRoomScore() async {
    prefs = await SharedPreferences.getInstance();
    // 判断是否存在 data
    if (prefs.containsKey("roomScore")) {
      int valKey = prefs.getInt("roomScore");
      print(valKey);
      // 计算相差时间
      int time = DateTime.now().millisecondsSinceEpoch - valKey;
      print("RoomScorePageProvider roomScore logs (请求间隔) ->time $time 毫秒");
      int min = time ~/ (1000 * 60);
      print(
          "RoomScorePageProvider roomScore logs (请求间隔) ->time/(1000 * 60) $min 分");
      // 判断是否超时
      // 缓存60 分钟
      if (min < 0) {
        String jsonRoomScore = prefs.getString(valKey.toString());
        roomScores = RoomScore.jsonListToRoomScoreList(jsonDecode(jsonRoomScore));
        if (roomScores != null && roomScores.isNotEmpty) {
          notifyListeners();
          return;
        }
      }
    }
    // 没有缓存，直接请求数据
    roomScores = await commonService.getRoomScore();
    notifyListeners();
  }
}
