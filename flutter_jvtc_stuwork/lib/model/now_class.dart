class NowClass {
  String name;
  String teacher;
  String aClass;
  String time;
  String address;
  String addressDetail;
  String status;
  String type;
  String allTime;

  NowClass(
      {this.name:"",
      this.teacher:"",
      this.aClass:"",
      this.time:"",
      this.address:"",
      this.addressDetail:"",
      this.status:"",
      this.type:"",
      this.allTime:""});


  @override
  String toString() {
    return 'NowClass{name: $name, teacher: $teacher, aClass: $aClass, time: $time, address: $address, addressDetail: $addressDetail, status: $status, type: $type, allTime: $allTime}';
  }

  factory NowClass.fromJson(dynamic json) {
    return NowClass(
      name: json['name'],
      teacher: json['teacher'],
      aClass: json['aClass'],
      time: json['time'],
      address: json['address'],
      addressDetail: json['addressDetail'],
      status: json['status'],
      type: json['type'],
      allTime: json['allTime'],
    );
  }

  Map toJson() {
    Map map = new Map();
    map["name"] = this.name;
    map["teacher"] = this.teacher;
    map["aClass"] = this.aClass;
    map["time"] = this.time;
    map["address"] = this.address;
    map["addressDetail"] = this.addressDetail;
    map["status"] = this.status;
    map["type"] = this.type;
    map["allTime"] = this.allTime;
    return map;
  }

  static arrayJsonToArrayModel(List json) {
    List<List<NowClass>> list = <List<NowClass>>[];
    json.forEach((element) {
      List<NowClass> temp = <NowClass>[];
      element.forEach((el) {
        NowClass nc = NowClass();
        try {
          nc = NowClass(
              name: el[0],
              teacher: el[1],
              aClass: el[2],
              time: el[3],
              address: el[4],
              addressDetail: el[5],
              status: el[6],
              type: el[7],
              allTime: el[8]);
        } catch (e) {
          // 是个时候没课
//          print("eee -> $e");
        }
        temp.add(nc);
      });
      list.add(temp);
    });
    return list;
  }
}
