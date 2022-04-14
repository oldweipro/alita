import 'dart:developer';

import 'package:alita/base/style.dart';
import 'package:alita/db/alita_cache.dart';
import 'package:alita/http/dao/login_dao.dart';
import 'package:alita/navigator/alita_navigator.dart';
import 'package:alita/widget/button.dart';
import 'package:alita/widget/input_view.dart';
import 'package:flutter/material.dart';

///登录页面
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final FocusNode _nodePhone = FocusNode();
  final FocusNode _nodePassword = FocusNode();

  bool _isClick = false;

  void _login() async {
    AlitaCache.getInstance().setString('login_phone', _phoneController.text);

    Navigator.pop(context);
  }

  Widget _buildBodyView() {
    return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("密码登陆", style: TextStyles.textBoldDark26),
              Gaps.vGap16,
              CustomTextField(
                  focusNode: _nodePhone,
                  controller: _phoneController,
                  maxLength: 11,
                  nextFocusNode: _nodePassword,
                  keyboardType: TextInputType.phone,
                  hintText: "输入手机号"),
              Gaps.vGap10,
              CustomTextField(
                  focusNode: _nodePassword,
                  isInputPwd: true,
                  controller: _passwordController,
                  maxLength: 16,
                  hintText: "输入密码"),
              Gaps.vGap25,
              Button(
                  onPressed: _isClick ? _login : () {},
                  child: Text('登陆', style: TextStyle(fontSize: 18)),
                  borderRadius: 0),
              Gaps.vGap16,
              Container(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      child: Padding(
                          child: Text('忘记密码',
                              style: TextStyles.textGrey14),
                          padding: EdgeInsets.all(10)),
                      onTap: () => log(
                          "跳转新页面pushNewPage(context, ResetPasswordPage())"))),
              Gaps.vGap6,
              Container(
                  alignment: Alignment.center,
                  child: InkWell(
                      child: Padding(
                          child: Text('去注册', style: TextStyles.textBlue16),
                          padding: EdgeInsets.all(10)),
                      onTap: () =>
                          log("跳转新页面pushNewPage(context, RegisterPage())")))
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            leading: const CloseButton(),
            iconTheme: const IconThemeData(color: Colors.black54),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                child: TextButton(
                    child: const Text(
                      "快速登陆",
                      style: TextStyles.textDark14,
                    ),
                    onPressed: () => {
                          // AlitaCache.getInstance().setString(LoginDao.boardingPass, "token");
                          // AlitaNavigator.getInstance().onJumpTo(RouteStatus.home);
                          log("登陆")
                        }),
              ),
            ]),
        body: SingleChildScrollView(child: _buildBodyView()));
  }
}
