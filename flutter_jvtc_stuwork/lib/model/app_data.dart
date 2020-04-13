class AppData{
  // 今日访问
  int toDayApiNum;
  // 访问量
  int toMonthApisNum;
  // 总用户
  int toAllUserNum;
  // 今日新增
  int toDayNewUserNum;

  AppData({this.toDayApiNum:0, this.toMonthApisNum:0, this.toAllUserNum:0,
    this.toDayNewUserNum:0});

  factory AppData.fromJson(dynamic json) {
    return AppData(
      toDayApiNum:json['toDayApiNum'],
      toMonthApisNum:json['toMonthApisNum'],
      toAllUserNum:json['toAllUserNum'],
      toDayNewUserNum:json['toDayNewUserNum'],
    );
  }
  Map toJson() {
    Map map = new Map<String,int>();
    map["toDayApiNum"] = this.toDayApiNum;
    map["toMonthApisNum"] = this.toMonthApisNum;
    map["toAllUserNum"] = this.toAllUserNum;
    map["toDayNewUserNum"] = this.toDayNewUserNum;
    return map;
  }

  @override
  String toString() {
    return 'AppData{toDayApiNum: $toDayApiNum, toMonthApisNum: $toMonthApisNum, toAllUserNum: $toAllUserNum, toDayNewUserNum: $toDayNewUserNum}';
  }
}
