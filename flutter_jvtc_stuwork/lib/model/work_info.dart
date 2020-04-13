class WorkInfo {
  // 早操缺勤
  String absence;

  // 旷课
  String truant;

//  晚自习缺勤
  String study;

  //违纪
  String Illegal;

  // 挂科
  String Failing;

  // 平均成绩
  String grade;

  // 学分
  String score;

  // 不及格
  String flunk;

  @override
  String toString() {
    return 'WorkInfo{absence: $absence, truant: $truant, study: $study, Illegal: $Illegal, Failing: $Failing, grade: $grade, score: $score, flunk: $flunk}';
  }

  WorkInfo(
      {this.absence:"0",
      this.truant:"0",
      this.study:"0",
      this.Illegal:"0",
      this.Failing:"0",
      this.grade:"0",
      this.score:"0",
      this.flunk:"0"});

  factory WorkInfo.fromJson(dynamic json) {
    return WorkInfo(
      absence: json['absence'],
      truant: json['truant'],
      study: json['study'],
      Illegal: json['Illegal'],
      Failing: json['Failing'],
      grade: json['grade'],
      score: json['score'],
      flunk: json['flunk'],
    );
  }
  Map toJson() {
    Map map = new Map();
    map["absence"] = this.absence;
    map["truant"] = this.truant;
    map["study"] = this.study;
    map["Illegal"] = this.Illegal;
    map["Failing"] = this.Failing;
    map["grade"] = this.grade;
    map["score"] = this.score;
    map["flunk"] = this.flunk;
    return map;
  }

}
