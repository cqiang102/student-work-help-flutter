import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jvtc_stuwork/model/user_info.dart';

class UserInfoPage extends StatefulWidget {
  UserInfo userInfo = UserInfo(basicsInfo: BasicsInfo(),contactInfo: ContactInfo(),homeInfo: HomeInfo(),schoolInfo: SchoolInfo());
  VoidCallback initData;


  UserInfoPage({this.userInfo, this.initData});

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  void initState() {
    widget.initData();
  }
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750.0;
    TextStyle labelStyle = TextStyle(fontSize: 35 * rpx);
    TextStyle bodyStyle = TextStyle(fontSize: 34 * rpx);
    buildBodyLine(String text) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10 * rpx),
        child: Text(
          text,
          style: bodyStyle,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text("个人信息"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Image.asset(
              "images/chat0.jpg",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 20 * rpx),
                padding: EdgeInsets.symmetric(
                    vertical: 10 * rpx, horizontal: 20 * rpx),
                child: Column(
                  children: <Widget>[
                    // 个人信息
                    Container(
                      margin: EdgeInsets.only(bottom: 30 * rpx),
                      padding: EdgeInsets.symmetric(
                          horizontal: 25 * rpx, vertical: 20 * rpx),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10 * rpx),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1 * rpx,
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("个人信息",style: labelStyle,),
                          Container(
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey[400],
                            margin: EdgeInsets.symmetric(
                                horizontal: 5 * rpx, vertical: 10 * rpx),
                          ),
                          buildBodyLine("姓名：${widget.userInfo.basicsInfo.studentName}"),
                          buildBodyLine("学号：${widget.userInfo.basicsInfo.studentNo}"),
                          buildBodyLine("校区：${widget.userInfo.basicsInfo.campus}"),
                          buildBodyLine("出生年月：${widget.userInfo.basicsInfo.birthDay}"),
                          buildBodyLine("民族：${widget.userInfo.basicsInfo.national}"),
                          buildBodyLine("政治面貌：${widget.userInfo.basicsInfo.polity}"),
                          buildBodyLine("籍贯：${widget.userInfo.basicsInfo.nativePlace}"),
                          buildBodyLine("入学时间：${widget.userInfo.basicsInfo.inTime}"),
                          buildBodyLine("文化程度：${widget.userInfo.basicsInfo.WHCD}"),
                          buildBodyLine("入学成绩：${widget.userInfo.basicsInfo.RXCJ}"),
                          buildBodyLine("文理：${widget.userInfo.basicsInfo.KL}"),
                          buildBodyLine("身份证：${widget.userInfo.basicsInfo.idCard}"),
                          buildBodyLine("类型：${widget.userInfo.basicsInfo.getType1}"),
                          buildBodyLine("银行卡类型：${widget.userInfo.basicsInfo.bankName}"),
                          buildBodyLine("银行卡号：${widget.userInfo.basicsInfo.bankNo}"),
                          buildBodyLine("校园卡号：${widget.userInfo.basicsInfo.oneCard}"),

                        ],
                      ),
                    ),
                    // 联系方式
                    Container(
                      margin: EdgeInsets.only(bottom: 30 * rpx),
                      padding: EdgeInsets.symmetric(
                          horizontal: 25 * rpx, vertical: 20 * rpx),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10 * rpx),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1 * rpx,
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("联系方式",style: labelStyle,),
                          Container(
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey[400],
                            margin: EdgeInsets.symmetric(
                                horizontal: 5 * rpx, vertical: 10 * rpx),
                          ),
                          buildBodyLine("手机号：${widget.userInfo.contactInfo.moveTel}"),
                          buildBodyLine("邮箱：${widget.userInfo.contactInfo.email}"),
                          buildBodyLine("QQ：${widget.userInfo.contactInfo.QQCard}"),
                          buildBodyLine("微信：${widget.userInfo.contactInfo.WXH}"),

                        ],
                      ),
                    ),
                    // 家庭信息
                    Container(
                      margin: EdgeInsets.only(bottom: 30 * rpx),
                      padding: EdgeInsets.symmetric(
                          horizontal: 25 * rpx, vertical: 20 * rpx),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10 * rpx),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1 * rpx,
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("家庭信息",style: labelStyle,),
                          Container(
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey[400],
                            margin: EdgeInsets.symmetric(
                                horizontal: 5 * rpx, vertical: 10 * rpx),
                          ),
                          buildBodyLine("父亲：${widget.userInfo.homeInfo.fatherName}"),
                          buildBodyLine("母亲：${widget.userInfo.homeInfo.motherName}"),
                          buildBodyLine("父亲联系方式：${widget.userInfo.homeInfo.fatherTel}"),
                          buildBodyLine("母亲联系方式：${widget.userInfo.homeInfo.motherTel}"),

                        ],
                      ),
                    ),
                    // 在校信息
                    Container(
                      margin: EdgeInsets.only(bottom: 30 * rpx),
                      padding: EdgeInsets.symmetric(
                          horizontal: 25 * rpx, vertical: 20 * rpx),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10 * rpx),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1 * rpx,
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("在校信息",style: labelStyle,),
                          Container(
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey[400],
                            margin: EdgeInsets.symmetric(
                                horizontal: 5 * rpx, vertical: 10 * rpx),
                          ),
                          buildBodyLine("学历类型：${widget.userInfo.schoolInfo.speType}"),
                          buildBodyLine("状态：${widget.userInfo.schoolInfo.inStatus}"),
                          buildBodyLine("学院：${widget.userInfo.schoolInfo.collegeNo}"),
                          buildBodyLine("专业：${widget.userInfo.schoolInfo.specialtyNo}"),
                          buildBodyLine("入学年级：${widget.userInfo.schoolInfo.grade}"),
                          buildBodyLine("班级：${widget.userInfo.schoolInfo.classNo}"),
                          buildBodyLine("宿舍：${widget.userInfo.schoolInfo.bedNo}"),

                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
