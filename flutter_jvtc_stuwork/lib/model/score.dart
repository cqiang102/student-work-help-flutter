class ScoreModel {
  /// 课程名称
  String name;

  /// 课程属性
  String attr;

  /// 成绩
  String score;

  /// 学分
  String stuScore;

  ScoreModel({this.name:"name", this.attr:"attr", this.score:"80", this.stuScore:"3.0"});

  factory ScoreModel.fromJson(dynamic json) {
    return ScoreModel(
      name: json['name'],
      attr: json['attr'],
      score: json['score'],
      stuScore: json['stuScore'],
    );
  }

  @override
  String toString() {
    return 'ScoreModel{name: $name, attr: $attr, score: $score, stuScore: $stuScore}';
  }

  Map toJson() {
    Map map = new Map();
    map["name"] = this.name;
    map["attr"] = this.attr;
    map["score"] = this.score;
    map["stuScore"] = this.stuScore;
    return map;
  }
  static jsonDataToModel(Map json){
    Map<String,List<ScoreModel>> map = Map();

    json.forEach((key, value) {
      List listValue = value;
      List<ScoreModel> listModel = <ScoreModel>[];
      listValue.forEach((element) {
        List listElement = element;
        listModel.add(ScoreModel(name: listElement[1],attr: listElement[9],score: listElement[3],stuScore: listElement[5]));
      });
      map[key]=listModel;
    });
    return map;
  }

  static Map jsonModelToModel(json) {
    Map<String,List<ScoreModel>> map = Map();

    json.forEach((key, value) {
      List listValue = value;
      List<ScoreModel> listModel = <ScoreModel>[];
      listValue.forEach((element) {
        listModel.add(ScoreModel.fromJson(element));
      });
      map[key]=listModel;
    });
    return map;
  }
}
