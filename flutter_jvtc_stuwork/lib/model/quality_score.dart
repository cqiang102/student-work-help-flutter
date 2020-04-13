class QualityScore{
  String CountA1;
  String CountB1;
  String CountC1;
  String CountD1;
  String CountE1;
  String CountF1;
  String SunCount1;
  String Status;

  QualityScore({this.CountA1:"0.000", this.CountB1:"0.000", this.CountC1:"0.000", this.CountD1:"0.000",
    this.CountE1:"0.000", this.CountF1:"0.000", this.SunCount1:"0.000", this.Status:"可以毕业"});

  factory QualityScore.fromJson(dynamic json) {
    return QualityScore(
      CountA1: json['CountA1'],
      CountB1: json['CountB1'],
      CountC1: json['CountC1'],
      CountD1: json['CountD1'],
      CountE1: json['CountE1'],
      CountF1: json['CountF1'],
      SunCount1: json['SunCount1'],
      Status: json['Status'],
    );
  }

  @override
  String toString() {
    return 'QualityScore{CountA1: $CountA1, CountB1: $CountB1, CountC1: $CountC1, CountD1: $CountD1, CountE1: $CountE1, CountF1: $CountF1, SunCount1: $SunCount1, Status: $Status}';
  }

  Map toJson() {
    Map map = new Map();
    map["CountA1"] = this.CountA1;
    map["CountB1"] = this.CountB1;
    map["CountC1"] = this.CountC1;
    map["CountD1"] = this.CountD1;
    map["CountE1"] = this.CountE1;
    map["CountF1"] = this.CountF1;
    map["SunCount1"] = this.SunCount1;
    map["Status"] = this.Status;
    return map;
  }


}
