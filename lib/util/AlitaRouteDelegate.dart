import 'dart:developer';

import 'package:alita/db/alita_cache.dart';
import 'package:alita/http/core/alita_error.dart';
import 'package:alita/http/core/alita_net.dart';
import 'package:alita/http/dao/login_dao.dart';
import 'package:alita/model/video_model.dart';
import 'package:alita/navigator/alita_navigator.dart';
import 'package:alita/navigator/bottom_navigator.dart';
import 'package:alita/page/dark_mode_page.dart';
import 'package:alita/page/login_page.dart';
import 'package:alita/page/registration_page.dart';
import 'package:alita/page/video_detail_page.dart';
import 'package:flutter/material.dart';

class AlitaRouteDelegate extends RouterDelegate<AlitaRoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<AlitaRoutePath> {
  //为Navigator设置一个key，必要的时候可以通过navigatorKey.currentState来获取到NavigatorState对象
  AlitaRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    //实现路由跳转逻辑 路由传参
    AlitaNavigator.getInstance().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map? args}) {
          _routeStatus = routeStatus;
          if (routeStatus == RouteStatus.detail) {
            videoModel = args!['videoMo'];
          }
          notifyListeners();
        }));
    //设置网络错误拦截器
    AlitaNet.getInstance().setErrorInterceptor((error) {
      if (error is NeedLogin) {
        //清空失效的登录令牌
        AlitaCache.getInstance().remove(LoginDao.boardingPass);
        //拉起登录
        AlitaNavigator.getInstance().onJumpTo(RouteStatus.login);
      }
    });
  }

  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];
  VideoModel? videoModel;

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      //要打开的页面在栈中已存在，则将该页面和它上面的所有页面进行出栈
      //tips 具体规则可以根据需要进行调整，这里要求栈中只允许有一个同样的页面的实例
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      //跳转首页时将栈中其它页面进行出栈，因为首页不可回退
      pages.clear();
      page = pageWrap(const BottomNavigator());
    } else if (routeStatus == RouteStatus.darkMode) {
      page = pageWrap(const DarkModePage());
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoModel: videoModel!));
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(const RegistrationPage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(const LoginPage());
    }
    //重新创建一个数组，否则pages因引用没有改变路由不会生效
    tempPages = [...tempPages, page];
    //通知路由发生变化
    AlitaNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages;
    return WillPopScope(
      //fix Android物理返回键，无法返回上一页问题@https://github.com/flutter/flutter/issues/66349
      onWillPop: () async =>
      !(await navigatorKey.currentState?.maybePop() ?? false),
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (route, result) {
          if (route.settings is MaterialPage) {
            //登录页未登录返回拦截
            if ((route.settings as MaterialPage).child is LoginPage) {
              if (!hasLogin) {
                log("请先登录，用showToast通知");
                return false;
              }
            }
          }
          //执行返回操作
          if (!route.didPop(result)) {
            return false;
          }
          var tempPages = [...pages];
          pages.removeLast();
          //通知路由发生变化
          AlitaNavigator.getInstance().notify(pages, tempPages);
          return true;
        },
      ),
    );
  }

  RouteStatus get routeStatus {
    // 校验登录状态，如果不是注册页面并且缓存中获取不到token则跳转到登录页
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else {
      return _routeStatus;
    }
  }

  // 校验缓存中是否有token
  bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Future<void> setNewRoutePath(AlitaRoutePath configuration) async {}

}

///定义路由数据，path
class AlitaRoutePath {
  final String location;
  AlitaRoutePath.home() : location = "/";
}