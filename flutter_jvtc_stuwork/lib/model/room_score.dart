class RoomScore{
  /// 宿舍
  String dorm;
  /// 分数
  String score;
  /// 状态
  String grade;
  /// 来源
  String source;
  /// 时间
  String time;
  /// 周次
  String week;

  RoomScore(
  {this.dorm, this.score, this.grade, this.source, this.time, this.week});

  factory RoomScore.fromJson(dynamic json) {
    return RoomScore(
      dorm:json['dorm'],
      score:json['score'],
      grade:json['grade'],
      source:json['source'],
      time:json['time'],
      week:json['week'],
    );
  }
  Map toJson() {
    Map map = new Map<String,String>();
    map["dorm"] = this.dorm;
    map["score"] = this.score;
    map["grade"] = this.grade;
    map["source"] = this.source;
    map["time"] = this.time;
    map["week"] = this.week;
    return map;
  }

  @override
  String toString() {
    return 'RoomScore{dorm: $dorm, score: $score, grade: $grade, source: $source, time: $time, week: $week}';
  }

  static List<RoomScore> jsonListToRoomScoreList(List json) {
    List<RoomScore> list = [];
    json.forEach((element) {
      list.add(RoomScore.fromJson(element));
    });
    return list;
  }
}
