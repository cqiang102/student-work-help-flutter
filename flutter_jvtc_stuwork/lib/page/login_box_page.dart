import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jvtc_stuwork/model/login_result.dart';
import 'package:flutter_jvtc_stuwork/service/common_service.dart';
import 'package:flutter_jvtc_stuwork/utils/string_utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class LoginBox extends StatefulWidget {
  @override
  _LoginBoxState createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode focusNodeAccount = FocusNode();
  final FocusNode focusPassword = FocusNode();
  final CommonService commonService = CommonService();
  bool autoLogin = false;
  bool rememberPassword = false;
  Timer timer;
  SharedPreferences prefs;
  RaisedButton loginButton;
  bool ifAuto = true;
  bool ifLoading = false;

  @override
  void initState() {
    _initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750.0;
    double margin = 60 * rpx;
    Map obj = ModalRoute.of(context).settings.arguments;
    if (obj != null && obj.isNotEmpty) {
      ifAuto = obj["auto"];
    }
    loginButton = RaisedButton(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(40 * rpx)),
      color: Colors.green,
      child: Text(
        "登录",
        style: TextStyle(fontSize: 40 * rpx, color: Colors.grey[300]),
      ),
      onPressed: () {
        _onSubmit();
      },
    );
    return Stack(
      children: <Widget>[
        Container(
          width: 750 * rpx - 2 * margin,
          margin: EdgeInsets.symmetric(horizontal: margin),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 20 * rpx, vertical: 20 * rpx),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20 * rpx),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 20 * rpx,
                          color: Colors.black54,
                          offset: Offset(20 * rpx, 20 * rpx))
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20 * rpx),
                    ),
                    Text(
                      "九江职业技术学院-学工网",
                      style: TextStyle(
                          fontSize: 50 * rpx, color: Colors.grey[800]),
                    ),
                    LoginTextField(
                      labelText: "学工账号",
                      hinText: "请输入学工账号",
                      width: 750 * rpx - 2 * margin,
                      controller: accountController,
                      focusNode: focusNodeAccount,
                      obscure: false,
                      icon: Icon(
                        Icons.face,
                        size: 40 * rpx,
                      ),
                    ),
                    LoginTextField(
                      labelText: "密码",
                      hinText: "请输入密码",
                      width: 750 * rpx - 2 * margin,
                      controller: passwordController,
                      focusNode: focusPassword,
                      obscure: true,
                      icon: Icon(
                        Icons.lock,
                        size: 40 * rpx,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Switch(
                              onChanged: (bool value) {
                                setState(() {
                                  autoLogin = !autoLogin;
                                  if (autoLogin) {
                                    rememberPassword = true;
                                    prefs.setBool(
                                        "rememberPassword", rememberPassword);
                                  }
                                });
                                prefs.setBool("autoLogin", autoLogin);
                              },
                              value: autoLogin,
                            ),
                            Text(
                              "自动登录",
                              style: TextStyle(
                                  fontSize: 26 * rpx, color: Colors.grey[900]),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Switch(
                              onChanged: (bool value) {
                                setState(() {
                                  rememberPassword = !rememberPassword;
                                  if (rememberPassword == false) {
                                    prefs.setBool("password", null);
                                  }
                                  autoLogin = false;
                                });

                                prefs.setBool(
                                    "rememberPassword", rememberPassword);
                              },
                              value: rememberPassword,
                            ),
                            Text(
                              "记住密码",
                              style: TextStyle(
                                  fontSize: 26 * rpx, color: Colors.grey[900]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15 * rpx),
              ),
              Row(children: <Widget>[
                Expanded(
                  child: loginButton,
                ),
              ]),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40 * rpx)),
                color: Colors.grey[800],
                child: Text(
                  "免登录查课表",
                  style: TextStyle(fontSize: 22 * rpx, color: Colors.grey[300]),
                ),
                onPressed: () {
                  String account = accountController.text;
                  if (account == null || account == "") {
                    FocusScope.of(context).requestFocus(focusNodeAccount);
                  } else {
                    prefs.setString("account", account);
                    Navigator.of(context).pushNamed("curriculumPage");
                  }
                },
              )
            ],
          ),
        ),
        ifLoading
            ? Positioned.fill(
                child: Container(
                  color: Colors.transparent,
                  child: SpinKitFadingCircle(
                    // 可以画一个圈，分为 0 1 2 3 4 5 6 7 8 9 份
                    itemBuilder: (_, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          // isEven 表示是否整数
                          color: index.isEven ? Colors.red : Colors.green,
                            borderRadius: BorderRadius.circular(10 * rpx)
                        ),
                      );
                    },
                    size: 80.0,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();

    // test
//    prefs.setBool("autoLogin", true);
//    prefs.setBool("rememberPassword", true);

    bool prefsAutoLogin = prefs.getBool("autoLogin");
    bool prefsRememberPassword = prefs.getBool("rememberPassword");
    String account = prefs.getString("account");
    String password = prefs.getString("password");

    setState(() {
      autoLogin = prefsAutoLogin == null ? false : prefsAutoLogin;
      rememberPassword =
          prefsRememberPassword == null ? false : prefsRememberPassword;
      accountController.text = account;
      passwordController.text = password;
    });
    print("autoLogin $autoLogin");
    print("rememberPassword $rememberPassword");
    if (autoLogin && ifAuto) {
      timer = Timer.periodic(Duration(seconds: 1), (_) async {
        if (_validate(account, password)) {
          if (ifLoading == false) {
            setState(() {
              ifLoading = true;
            });
            LoginResult result = await commonService.login(account, password);
            if (result.status) {
              setState(() {
                ifLoading = false;
              });
              // 登录成功，跳转页面
              Navigator.of(context).pushReplacementNamed("main");
            } else {
              setState(() {
                ifLoading = false;
              });
              // 登录失败，弹出提示
              _showDialog("登录失败", result.message);
            }
          }
        }
        print("登录");
        timer.cancel();
      });
    }
  }

  _showDialog(String title, String content) {
    double rpx = MediaQuery.of(context).size.width / 750;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white.withOpacity(0.8),
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(10 * rpx)),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            content: Text(
              content,
              textAlign: TextAlign.center,
            ),
          );
        });
  }

  _onSubmit() async {
    setState(() {
      ifLoading = true;
    });
    String account = accountController.text;
    String password = passwordController.text;

    if (_validate(account, password)) {
      // 登录
      LoginResult result = await commonService.login(account, password);
      if (result.status) {
        prefs.setString("account", account);
        prefs.setString("password", rememberPassword ? password : null);
        // 登录成功，跳转页面
        setState(() {
          ifLoading = false;
        });
        Navigator.of(context).pushReplacementNamed("main");
      } else {
        // 登录失败，弹出提示
        setState(() {
          ifLoading = false;
        });
        _showDialog("登录失败", result.message);
      }
    }
  }

  bool _validate(String account, String password) {
    if (StringUtils.isNull(account) || StringUtils.isNull(password)) {
      setState(() {
        ifLoading = false;
      });
      Toast.show("不能留空哦", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return false;
    }
    return true;
  }
}

class LoginTextField extends StatefulWidget {
  LoginTextField({
    @required this.controller,
    @required this.obscure,
    @required this.icon,
    @required this.width,
    @required this.hinText,
    @required this.labelText,
    @required this.focusNode,
  });

  final TextEditingController controller;
  final bool obscure;
  final Icon icon;
  final double width;
  final String hinText;
  final String labelText;
  final FocusNode focusNode;

  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  Color color = Colors.grey;
  String errorText;

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750.0;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20 * rpx),
      width: widget.width,
      child: TextField(
        onChanged: (val) {
          String temp;
          if (val == null || val == "" || val.isEmpty) {
            temp = widget.labelText + "不能为空";
          }
          setState(() {
            errorText = temp;
          });
        },
        controller: widget.controller,
        obscureText: widget.obscure,
        style: TextStyle(fontSize: 30 * rpx),
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          errorText: errorText,
          labelText: widget.labelText,
          labelStyle: TextStyle(fontSize: 40.0 * rpx),
          hintStyle: TextStyle(fontSize: 30.0 * rpx),
          border: InputBorder.none,
          icon: widget.icon,
          hintText: widget.hinText,
        ),
      ),
    );
  }
}
