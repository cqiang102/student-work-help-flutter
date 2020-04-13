import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_jvtc_stuwork/model/app_data.dart';
import 'package:flutter_jvtc_stuwork/model/login_result.dart';
import 'package:flutter_jvtc_stuwork/model/now_class.dart';
import 'package:flutter_jvtc_stuwork/model/quality_doing.dart';
import 'package:flutter_jvtc_stuwork/model/quality_score.dart';
import 'package:flutter_jvtc_stuwork/model/room_score.dart';
import 'package:flutter_jvtc_stuwork/model/score.dart';
import 'package:flutter_jvtc_stuwork/model/user_info.dart';
import 'package:flutter_jvtc_stuwork/model/work_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonService {
  static final String host = "http://api.ncgame.cc/jvtc";
  static final String scoreHost = "https://jvtc.notbucai.com/jwxt";

  Dio dio;

  BaseOptions options;

  SharedPreferences prefs;

  CommonService() {
    init();
  }

  init() async {
    options = BaseOptions(
      baseUrl: host,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      sendTimeout: 5000,
      connectTimeout: 5000,
      receiveTimeout: 5000,
    );
    dio = Dio(options);
    prefs = await SharedPreferences.getInstance();
  }

  Future<LoginResult> login(String account, String password) async {
    print("CommonService logs (登录)-> account $account - password $password");
    try {
      Response res = await dio
          .post("/login", data: {"loginName": account, "loginPwd": password});
      var data = res.data;
      print("CommonService logs (登录结果)-> data ${data.toString()}");
      try {
        var code = data['code'];
        if (code == 0) {
          bool ifOK = await prefs.setString("token", data['token']);
          if (ifOK) {
            return LoginResult(status: true, message: data['message']);
          } else {
            return LoginResult(status: false, message: "token 解析失败");
          }
        } else {
          return LoginResult(status: false, message: data['message']);
        }
      } catch (e) {
        return LoginResult(status: false, message: "解析参数失败");
      }
    } catch (e) {
      print("CommonService logs (登录异常)-> $e");
      return LoginResult(status: false, message: "网络异常");
    }
  }

  appAction(String id) async {
    addToken();
    print("CommonService logs (评价活动)-> id $id ");
    try {
      Response res = await dio.post("/AppAction", data: [
        {"id": "$id"}
      ]);
      var data = res.data;
      print("CommonService logs (评价活动)-> data ${data.toString()}");
      try {
        var code = data['code'];
        if (code == 0) {
          // TODO
          return true;
        } else {
          return false;
        }
      } catch (e) {
        return false;
      }
    } catch (e) {
      print("CommonService logs (评价活动异常)-> $e");
      return false;
    }
  }
  Future<bool> putIssues(String message) async {
    addToken();
    print("CommonService logs (意见反馈)-> message $message ");
    try {
      Response res = await dio.post("/msg", data: [
        {"msg": "$message"}
      ]);
      var data = res.data;
      print("CommonService logs (意见反馈)-> data ${data.toString()}");
      try {
        var code = data['code'];
        if (code == 0) {
          // TODO
          return true;
        } else {
          return false;
        }
      } catch (e) {
        return false;
      }
    } catch (e) {
      print("CommonService logs (意见反馈)-> $e");
      return false;
    }
  }

  Future<Map<String, List<ScoreModel>>> scoreData(String password) async {
    prefs = await SharedPreferences.getInstance();
    print("CommonService logs (查询成绩)->password $password ");
    addToken();
    try {
      if (prefs == null) {
        throw Exception("获取数据失败");
      }
      String account = prefs.getString("account");

      print(
          "CommonService logs (查询成绩)->account $account : password $password ");

      Response res = await dio.post("https://jvtc.notbucai.com/jwxt/cjcx",
          data: {"loginname": account, "passwrod": password});
      print("??? ${res.request.uri}");
      var data = res.data;
      print("CommonService logs (查询成绩)-> data ${data.toString()}");
      try {
        var code = data['code'];
        if (code == 200) {
          Map<String, List<ScoreModel>> map =
              ScoreModel.jsonDataToModel(data['data']);
          // 缓存数据
          int valKey = DateTime.now().millisecondsSinceEpoch;
          prefs.setInt("scoreData", valKey);
          prefs.setString(valKey.toString(), jsonEncode(map));
          print("CommonService logs (成绩数据转换)-> data ${map.toString()}");
          if (map == null || map.isEmpty) {
            return null;
          }
          return map;
        } else {
          return null;
        }
      } catch (e) {
        return null;
      }
    } catch (e) {
      print("CommonService logs (查询成绩异常)-> $e");
      return null;
    }
  }

  getWorkInfo() async {
    addToken();
    try {
      Response res = await dio.get("/WorkInfo");
      dynamic json = res.data;
      WorkInfo data = WorkInfo.fromJson(json["data"]);
      // 缓存数据
      int valKey = DateTime.now().millisecondsSinceEpoch;
      prefs.setInt("workinfo", valKey);
      prefs.setString(valKey.toString(), jsonEncode(data));
      print("CommonService logs (workInfo)-> ${data.toString()}");
      return data;
    } catch (e) {
      print("CommonService logs (workInfo 请求异常)-> $e");
      return WorkInfo();
    }
  }

  getAppData() async {
    addToken();
    try {
      Response res = await dio.get("/data");
      dynamic json = res.data;
      AppData data = AppData.fromJson(json["data"]);
      int valKey = DateTime.now().millisecondsSinceEpoch;
      prefs.setInt("appData", valKey);
      prefs.setString(valKey.toString(), jsonEncode(data));
      print("CommonService logs (appData)-> ${data.toString()}");
      return data;
    } catch (e) {
      print("CommonService logs (appData 请求异常)-> $e");
      return AppData();
    }
  }

  getUserInfo() async {
    addToken();
    try {
      Response res = await dio.get("/user_info");
      dynamic json = res.data;
      UserInfo userInfo = UserInfo.fromJson(json["data"]);
      int valKey = DateTime.now().millisecondsSinceEpoch;
      prefs.setInt("userInfo", valKey);
      prefs.setString(valKey.toString(), jsonEncode(userInfo));
      print("CommonService logs (userInfo)-> ${userInfo.toString()}");
      return userInfo;
    } catch (e) {
      print("CommonService logs (userInfo 请求异常)-> $e");
      return UserInfo(
          basicsInfo: BasicsInfo(),
          contactInfo: ContactInfo(),
          homeInfo: HomeInfo(),
          schoolInfo: SchoolInfo());
    }
  }

  getQualityScore() async {
    addToken();
    try {
      Response res = await dio.get("/MyActionGetNum");
      dynamic json = res.data;
      QualityScore qualityScore = QualityScore.fromJson(json["data"]);
      int valKey = DateTime.now().millisecondsSinceEpoch;
      prefs.setInt("qualityScore", valKey);
      prefs.setString(valKey.toString(), jsonEncode(qualityScore));
      print("CommonService logs (qualityScore)-> ${qualityScore.toString()}");
      return qualityScore;
    } catch (e) {
      print("CommonService logs (qualityScore 请求异常)-> $e");
      return QualityScore();
    }
  }

  getQualityDoing() async {
    addToken();
    try {
      Response res = await dio.get("/getStuActive");
      dynamic json = res.data;
      List<QualityDoing> qualityDoing =
          QualityDoing.jsonListToQualityScoreList(json["data"]);
      int valKey = DateTime.now().millisecondsSinceEpoch;
      prefs.setInt("qualityDoing", valKey);
      prefs.setString(valKey.toString(), jsonEncode(qualityDoing));
      print("CommonService logs (qualityDoing)-> ${qualityDoing.toString()}");
      return qualityDoing;
    } catch (e) {
      print("CommonService logs (qualityDoing 请求异常)-> $e");
      return QualityDoing();
    }
  }

  getRoomScore() async {
    addToken();
    try {
      Response res = await dio.get("/StuEnlightenRoomScore");
      dynamic json = res.data;
      List<RoomScore> roomScores =
          RoomScore.jsonListToRoomScoreList(json["data"]);
      int valKey = DateTime.now().millisecondsSinceEpoch;
      prefs.setInt("roomScore", valKey);
      print("CommonService logs (roomScore -3)-> ${roomScores.toString()}");
      prefs.setString(valKey.toString(), jsonEncode(roomScores));
      print("CommonService logs (roomScore)-> ${roomScores.toString()}");
      return roomScores;
    } catch (e) {
      print("CommonService logs (roomScore 请求异常)-> ${e.toString()}");

      return <RoomScore>[];
    }
  }
  Future<Map> getWeek() async {
    Map map = Map();
    try {
      if(dio == null){
        init();
      }
      Response res = await dio.get("https://jvtc.notbucai.com/jwxt/course/week");
      dynamic json = res.data;
      if(json["code"]==200){
        map["currentWeek"]="${json["data"]["currentWeek"]}";
        map["totalWeek"]="${json["data"]["totalWeek"]}";
        int valKey = DateTime.now().millisecondsSinceEpoch;
        prefs.setInt("getWeek", valKey);
        prefs.setString(valKey.toString(), jsonEncode(map));
        print("CommonService logs (getWeek)-> ${map.toString()}");
        return map;
      }else{
        throw Exception("请求出错");
      }
    } catch (e) {
      print("CommonService logs (getWeek 请求异常)-> ${e.toString()}");
      return map;
    }
  }

  Future<List<List<dynamic>>> getCurriculum(
      String loginCode, String week) async {
    List<List<NowClass>> curriculum = <List<NowClass>>[];
    try {
      Response res = await Dio(BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        sendTimeout: 5000,
        connectTimeout: 5000,
        receiveTimeout: 5000,
      )).get(
          "https://jvtc.notbucai.com/jwxt/course?loginCode=$loginCode&week=$week");
      dynamic json = res.data;
      List listJson = (json["data"]['courseList']);
      curriculum = NowClass.arrayJsonToArrayModel(listJson);
      int valKey = DateTime.now().millisecondsSinceEpoch;

      prefs.setInt("curriculum-$week-${prefs.getString("account")}", valKey);
      prefs.setString(valKey.toString(), jsonEncode(listJson));
      print("CommonService logs (getCurriculum)-> $curriculum");
      return curriculum;
    } catch (e) {
      print("CommonService logs (getCurriculum 请求异常)-> ${e.toString()}");

      return curriculum;
    }
  }

  void addToken() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
    String token = prefs.getString("token");
    dio.options.headers["Authorization"] = "Bearer $token";
  }
}
