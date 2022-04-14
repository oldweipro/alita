import 'dart:developer';

import 'package:alita/base/color.dart';
import 'package:alita/navigator/alita_navigator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('主页'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            AlitaNavigator.getInstance().onJumpTo(RouteStatus.darkMode);
          },
          child: Container(
            //设置 child 居中
            alignment: const Alignment(0, 0),
            height: 30,
            width: 60,
            //边框设置
            decoration: BoxDecoration(
              //设置四周圆角 角度
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              //设置四周边框
              border: Border.all(width: 1, color: primary),
            ),
            child: const Text('主题'),
          ),
        ),
      ),
    );
  }

  var listener;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance?.addObserver(this);
    AlitaNavigator.getInstance().addListener(listener = (current, pre) {
      log('home:current:${current.page}');
      log('home:pre:${pre.page}');
      if (widget == current.page || current.page is HomePage) {
        log('打开了首页:onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        log('首页:onPause');
      }
      //当页面返回到首页恢复首页的状态栏样式
      // if (pre?.page is VideoDetailPage && !(current.page is ProfilePage)) {
      //   var statusStyle = StatusStyle.DARK_CONTENT;
      //   changeStatusBar(color: Colors.white, statusStyle: statusStyle);
      // }
    });
  }
}
