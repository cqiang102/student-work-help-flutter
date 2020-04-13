import 'package:flutter/cupertino.dart';

class UserInfo {
  /// 个人信息
  BasicsInfo basicsInfo;

  /// 联系方式
  ContactInfo contactInfo;

  /// 家庭信息
  HomeInfo homeInfo;

  /// 在校信息
  SchoolInfo schoolInfo;

  UserInfo(
      {@required this.basicsInfo,
      @required this.contactInfo,
      @required this.homeInfo,
      @required this.schoolInfo});

  factory UserInfo.fromJson(dynamic json) {
    return UserInfo(
      basicsInfo: BasicsInfo.fromJson(json['basicsinfo']),
      contactInfo: ContactInfo.fromJson(json['contactinfo']),
      homeInfo: HomeInfo.fromJson(json['homeinfo']),
      schoolInfo: SchoolInfo.fromJson(json['schoolinfo']),
    );
  }

  Map toJson() {
    Map map = new Map();
    map["basicsinfo"] = this.basicsInfo.toJson();
    map["contactinfo"] = this.contactInfo.toJson();
    map["homeinfo"] = this.homeInfo.toJson();
    map["schoolinfo"] = this.schoolInfo.toJson();
    return map;
  }

  @override
  String toString() {
    return 'UserInfo{basicsInfo: $basicsInfo, contactInfo: $contactInfo, homeInfo: $homeInfo, schoolInfo: $schoolInfo}';
  }
}

class BasicsInfo {
  /// 姓名
  String studentName;

  /// 学号
  String studentNo;

  /// 校区
  String campus;

  /// 出生年月
  String birthDay;

  /// 民族
  String national;

  /// 政治面貌
  String polity;

  /// 籍贯
  String nativePlace;

  /// 入学时间
  String inTime;

  /// 文化程度
  String WHCD;

  /// 入学成绩
  String RXCJ;

  /// 文理
  String KL;

  /// 身份证
  String idCard;

  /// 类型
  String getType1;

  /// 银行类型
  String bankName;

  /// 银行卡号
  String bankNo;

  /// 校园卡号
  String oneCard;

  @override
  String toString() {
    return 'BasicsInfo{studentName: $studentName, studentNo: $studentNo, campus: $campus, birthDay: $birthDay, national: $national, polity: $polity, nativePlace: $nativePlace, inTime: $inTime, WHCD: $WHCD, RXCJ: $RXCJ, KL: $KL, idCard: $idCard, getType1: $getType1, bankName: $bankName, bankNo: $bankNo, oneCard: $oneCard}';
  }

  BasicsInfo(
      {this.studentName: "",
      this.studentNo: "",
      this.campus: "",
      this.birthDay: "",
      this.national: "",
      this.polity: "",
      this.nativePlace: "",
      this.inTime: "",
      this.WHCD: "",
      this.RXCJ: "",
      this.KL: "",
      this.idCard: "",
      this.getType1: "",
      this.bankName: "",
      this.bankNo: "",
      this.oneCard: ""});

  factory BasicsInfo.fromJson(dynamic json) {
    return BasicsInfo(
      studentName: json['StudentName'],
      studentNo: json['StudentNo'],
      campus: json['Campus'],
      birthDay: json['BirthDay'],
      national: json['National'],
      polity: json['Polity'],
      nativePlace: json['NativePlace'],
      inTime: json['InTime'],
      WHCD: json['WHCD'],
      RXCJ: json['RXCJ'],
      KL: json['KL'],
      idCard: json['IdCard'],
      getType1: json['GetType1'],
      bankName: json['BankName'],
      bankNo: json['BankNo'],
      oneCard: json['OneCard'],
    );
  }

  Map toJson() {
    Map map = new Map();
    map["StudentName"] = this.studentName;
    map["StudentNo"] = this.studentNo;
    map["Campus"] = this.campus;
    map["BirthDay"] = this.birthDay;
    map["National"] = this.national;
    map["Polity"] = this.polity;
    map["NativePlace"] = this.nativePlace;
    map["InTime"] = this.inTime;
    map["WHCD"] = this.WHCD;
    map["RXCJ"] = this.RXCJ;
    map["KL"] = this.KL;
    map["IdCard"] = this.idCard;
    map["GetType1"] = this.getType1;
    map["BankName"] = this.bankName;
    map["BankNo"] = this.bankNo;
    map["OneCard"] = this.oneCard;
    return map;
  }
}

class ContactInfo {

  /// 联系方式
  String moveTel;

  /// 邮箱
  String email;

  /// QQ
  String QQCard;

  /// 微信号
  String WXH;

  ContactInfo(
      {this.moveTel: "", this.email: "", this.QQCard: "", this.WXH: ""});

  factory ContactInfo.fromJson(dynamic json) {
    return ContactInfo(
      moveTel: json['MoveTel'],
      email: json['Email'],
      QQCard: json['QQCard'],
      WXH: json['WXH'],
    );
  }

  Map toJson() {
    Map map = new Map();
    map["MoveTel"] = this.moveTel;
    map["Email"] = this.email;
    map["QQCard"] = this.QQCard;
    map["WXH"] = this.WXH;
    return map;
  }

  @override
  String toString() {
    return 'ContactInfo{moveTel: $moveTel, email: $email, QQCard: $QQCard, WXH: $WXH}';
  }
}

class HomeInfo {

  /// 父亲
  String fatherName;

  /// 母亲
  String motherName;

  /// 父亲联系方式
  String fatherTel;

  /// 母亲联系方式
  String motherTel;

  factory HomeInfo.fromJson(dynamic json) {
    return HomeInfo(
      fatherName: json['FatherName'],
      motherName: json['MotherName'],
      fatherTel: json['FatherTel'],
      motherTel: json['MotherTel'],
    );
  }

  HomeInfo(
      {this.fatherName: "",
      this.motherName: "",
      this.fatherTel: "",
      this.motherTel: ""});

  Map toJson() {
    Map map = new Map();
    map["FatherName"] = this.fatherName;
    map["MotherName"] = this.motherName;
    map["FatherTel"] = this.fatherTel;
    map["MotherTel"] = this.motherTel;
    return map;
  }

  @override
  String toString() {
    return 'HomeInfo{fatherName: $fatherName, motherName: $motherName, fatherTel: $fatherTel, motherTel: $motherTel}';
  }
}

class SchoolInfo {
  /// 学历类型
  String speType;

  /// 状态
  String inStatus;

  /// 学院
  String collegeNo;

  /// 专业
  String specialtyNo;

  /// 入学年级
  String grade;

  /// 班级
  String classNo;

  /// 宿舍
  String bedNo;


  @override
  String toString() {
    return 'SchoolInfo{speType: $speType, inStatus: $inStatus, collegeNo: $collegeNo, specialtyNo: $specialtyNo, grade: $grade, classNo: $classNo, bedNo: $bedNo}';
  }

  factory SchoolInfo.fromJson(dynamic json) {
    return SchoolInfo(
      speType: json['SpeType'],
      inStatus: json['InStatus'],
      collegeNo: json['CollegeNo'],
      specialtyNo: json['SpecialtyNo'],
      grade: json['Grade'],
      classNo: json['ClassNo'],
      bedNo: json['BedNo'],
    );
  }

  Map toJson() {
    Map map = new Map();
    map["SpeType"] = this.speType;
    map["InStatus"] = this.inStatus;
    map["CollegeNo"] = this.collegeNo;
    map["SpecialtyNo"] = this.specialtyNo;
    map["Grade"] = this.grade;
    map["ClassNo"] = this.classNo;
    map["BedNo"] = this.bedNo;
    return map;
  }

  SchoolInfo(
      {this.speType: "",
      this.inStatus: "",
      this.collegeNo: "",
      this.specialtyNo: "",
      this.grade: "",
      this.classNo: "",
      this.bedNo: ""});
}
