
class QualityDoing{
  /// id
  String id;
  /// 名字
  String name;
  /// 主办方
  String unit;
  /// 时间
  String date;
  /// 活动类型
  String type;
  /// 分值
  String score;
  /// 状态
  String stat;

  QualityDoing({this.id:"0", this.name:"", this.unit:"", this.date:"", this.type:"", this.score:"",
    this.stat:""});
  factory QualityDoing.fromJson(dynamic json) {
    return QualityDoing(
      id: json['id'],
      name: json['name'],
      unit: json['unit'],
      date: json['date'],
      type: json['type'],
      score: json['score'],
      stat: json['stat'],
    );
  }

  @override
  String toString() {
    return 'QualityDoing{id: $id, name: $name, unit: $unit, date: $date, type: $type, score: $score, stat: $stat}';
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = this.id;
    map["name"] = this.name;
    map["unit"] = this.unit;
    map["date"] = this.date;
    map["type"] = this.type;
    map["score"] = this.score;
    map["stat"] = this.stat;
    return map;
  }
  static List<QualityDoing> jsonListToQualityScoreList(List json) {
    List<QualityDoing> list = [];
    json.forEach((element) {
      list.add(QualityDoing.fromJson(element));
    });
    return list;
  }
}
